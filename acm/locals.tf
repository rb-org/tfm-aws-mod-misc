locals {
  zones = "${keys(var.domains)}"

  // We can't get the first index of an empty array, so we add a blank string element as a default so it doesn't blow
  // up when the domain map is empty.
  domain = "${element(concat(local.domains, local.EMPTY_LIST), 0)}"

  # domain = "${element(concat(local.domains, local.EMPTY_LIST), 0)}"

  record_map = "${transpose(var.domains)}"
  domains    = "${distinct(compact(concat(keys(local.record_map), local.EMPTY_LIST)))}"
  // We use this empty list to work around HCL limitations.
  EMPTY_LIST = [""]
  // *.example.org and example.org only needs 1 validation record. We need to unduplicate those domains
  // If domains {} is empty the list will become [""], so we need to compact it.
  validations_needed = "${length(compact(distinct(split(",", replace(join(",", local.domains), "*.", "")))))}"
  // Because of HCL limitations we can't slice an empty array because it won't understand it's internally a string
  // type.
  // So we add an empty element of type string which we then compact away into an empty array.
  // Specifying a primary name causes the SANs to be short one name, changing the slice from 1 to 0 ensures all names are added as SANs
  // Downside is the primary name is also added as a SAN
  subject_alternative_names = "${distinct(compact(slice(concat(local.domains, local.EMPTY_LIST), 1, length(distinct(local.domains)) + 1)))}"
  create_certs = "${var.create_certs ? 1 : 0}"
  local_count  = "${(local.create_certs * local.validations_needed) > 0 ? 1:0}"
}
