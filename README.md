# dhis2-patient-enrollment-ig

This Implementation Guide (IG) contains a Logical Model representation of a simple DHIS2 Tracker Program. The IG is designed to showcase how FHIR Mapping Language (FML) can be used to convert the logical model of a DHIS2 Tracker Program into a FHIR Patient resource.

The guide provides all the necessary tools and files to try out FML to map DHIS2 metadata to FHIR resources. Follow the instructions below to set up your environment, compile the IG, and run transformations using the FHIR Validator CLI.

## Prerequisites

### Required Tools and Resources

Ensure the following tools and dependencies are installed on your system:

1. **[SUSHI](https://github.com/FHIR/sushi)**:
   - SUSHI compiles FHIR Shorthand (FSH) into valid FHIR definitions, such as Logical Models and StructureDefinitions.
   - **Dependencies for SUSHI**:
     - **[Node.js](https://nodejs.org/en)**: Required for running SUSHI.
     - **[Ruby](https://www.ruby-lang.org/en/downloads/)** and **[Jekyll](https://jekyllrb.com/docs/installation/)**: Required for the IG Publisher to generate Implementation Guides.
     - **[Java JDK](https://www.oracle.com/java/technologies/downloads/)** (version 17 or higher): Required for running the IG Publisher and FHIR Validator CLI.

   To install SUSHI, run:
   ```bash
   npm install -g fsh-sushi
   ```
   After installation, confirm SUSHI is available:
   ```bash
   sushi --help
   ```

2. **[Visual Studio Code](https://code.visualstudio.com/download)** (recommended):
   - Install the **[vscode-language-fsh](https://marketplace.visualstudio.com/items?itemName=FHIR-Shorthand.vscode-fsh)** extension for FSH syntax highlighting.
   - Install the **[FHIR Mapping Language Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=HealexSystems.fhir-mapping-language-support)** extension for working with `.map` files.

### Included In This Repository
1. **[IG Publisher](https://github.com/HL7/fhir-ig-publisher)**:
   - The IG Publisher processes your FSH files, validates the generated FHIR resources, and compiles `.map` files into valid `StructureMap` resources.

2. **[FHIR Validator CLI](https://github.com/hapifhir/org.hl7.fhir.validator):**
   - The FHIR Validator CLI executes transformations defined in the `StructureMap` files.

## Setup Instructions

### 1. **Install Dependencies**
Follow the prerequisites section to install Node.js, Ruby, Jekyll, Java, and SUSHI.

### 2. **Clone This Repository**
Clone this IG to your local machine:
```bash
git clone https://github.com/JohanGHole/dhis2-patient-enrollment-ig.git
cd dhis2-patient-enrollment-ig
```

### 3. **Run the IG Publisher**
The IG Publisher generates and validates the IG content, including `.map` files converted into `StructureMap` resources.

#### **Scripts in the Repository:**

1. **_getValidator**  
   - Pulls the latest FHIR Validator CLI. Run this script before running FML transformations, as it is needed to execute the maps:  
     **For Linux/macOS**:  
     ```bash
     ./_getValidator.sh
     ```
     **For Windows**:  
     ```cmd
     _getValidator.bat
     ```

2. **_updatePublisher**  
   - Updates the IG Publisher to the latest version. Run this before building to download the **IG publisher jar file**:  
     **For Linux/macOS**:  
     ```bash
     ./_updatePublisher.sh
     ```  
     **For Windows**:  
     ```cmd
     _updatePublisher.bat
     ```

3. **_genonce**  
   - Runs the IG Publisher once to generate the IG content and compile `.map` files into `StructureMap` resources.  
   - Use this when you want a single build:  
     **For Linux/macOS**:  
     ```bash
     ./_genonce.sh
     ```  
     **For Windows**:  
     ```cmd
     _genonce.bat
     ```

## How to Run a Transformation

### Step 1: Validate and Compile the IG
After running the IG Publisher (`_genonce`), the `StructureMap` resources will be available in the `output` folder.

### Step 2: Run the Transformation
The FHIR Validator CLI can execute transformations defined in the `StructureMap`. Here is an example command to run the `patientEnrollmentToPatientResource` transformation:

**For Linux/macOS:**
```bash
java -jar validator_cli.jar \
  fsh-generated/resources/Binary-patientEnrollmentExample.json \
  -output output/TransformedPatient.json \
  -ig output \
  -transform http://example.org/StructureMap/patientEnrollmentToPatientResource \
  -version 4.0.1
```

**For Windows:**
```cmd
java -jar validator_cli.jar ^
  fsh-generated/resources/Binary-patientEnrollmentExample.json ^
  -output output/TransformedPatient.json ^
  -ig output ^
  -transform http://example.org/StructureMap/patientEnrollmentToPatientResource ^
  -version 4.0.1
```

#### Explanation of the Command:
- **`fsh-generated/resources/Binary-patientEnrollmentExample.json`**:
  - Input file containing the `PatientEnrollmentProgram` logical model instance.
- **`-output output/TransformedPatient.json`**:
  - Output file for the `Patient` resource, transformed from the logical model.
- **`-ig output`**:
  - Points to the generated IG directory containing compiled `StructureMap` resources.
- **`-transform`**:
  - Specifies the URL of the `StructureMap` to apply (`http://example.org/StructureMap/patientEnrollmentToPatientResource`).
- **`-version`**:
  - Specifies the FHIR version (use `4.0.1` for FHIR R4).

### Step 3: Verify the Output
Open `TransformedPatient.json` to verify the transformation. This file will contain a valid FHIR `Patient` resource based on the input logical model.

You can modify the `.fsh` and `.map` files to experiment with different mappings or logical models. Re-run `_genonce.sh` to apply changes.


## Troubleshooting
- Ensure all tools are installed and available in your system’s PATH.
- If the `./_genonce` script fails, ensure Jekyll, Ruby, and the IG Publisher are properly configured.

If you encounter errors during transformation:
  - Validate the `.map` file using the FHIR Validator CLI with verbose output (`-tx`).
  - Try compiling the `.map` file into a `StructureMap` using the following command:
    ```bash
    java -jar validator_cli.jar -ig input/maps/patientEnrollmentToPatientResource.map -version 4.0.1
    ```
  - Check the `StructureMap` resource in the `output` directory for compilation issues.