Logical: PatientEnrollmentProgram
Title: "Patient Enrollment Program"
Parent: Base
Description: "A tracker program to manage patient information, designed for mapping to the FHIR Patient resource. This program captures key demographic and identifying details required for patient enrollment."
* enrollmentDate 1..1 date ""
* incidentDate 0..1 date ""
* uniqueId 0..1 string "Unique identiifer"
* firstName 0..1 string "First name"
* lastName 0..1 string "Last name"
* gender 0..1 code "Gender"
* gender from GenderVS (required)
* birthDate 0..1 date "Birth date"
* email 0..1 string "Email address"
* address 0..1 string "Country"
* city 0..1 string "City"
* state 0..1 string "State"
* zipCode 0..1 decimal "Zip code"
