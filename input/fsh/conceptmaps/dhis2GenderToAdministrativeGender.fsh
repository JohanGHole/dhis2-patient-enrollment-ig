Instance:     Dhis2GenderToAdministrativeGender
InstanceOf:   ConceptMap
Description:  "Mapping to and from DHIS2 gender option set coding to FHIR Administrative Gender."
Usage:        #definition
* meta.profile[+] = "http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-shareableconceptmap"
* meta.profile[+] = "http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-publishableconceptmap"

* name = "Dhis2GenderToAdministrativeGender"
* title = "ConceptMap to and from DHIS2 Gender option set to administrative gender"
* status = #active
* experimental = true

* group[+]
  * source = Canonical(GenderCS)
  * target = "http://hl7.org/fhir/administrative-gender"
  * insert ElementMap(Male, male, equivalent)
  * insert ElementMap(Female, female, equivalent)

* group[+]
  * source = "http://hl7.org/fhir/administrative-gender"
  * target = Canonical(GenderCS)
  * insert ElementMap(male, Male, equivalent)
  * insert ElementMap(female, Female, equivalent)