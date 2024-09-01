## Lab Context

1. N/A (Lab Environment)

<!-- Describe the context of the lab and any relevant information -->

## Public Changelog

<!-- 
Use the predefined format [TYPE] Verb Action. Example: 
- [FEATURE] Added new login option.
- [BUGFIX] Fixed issue with user authentication.
-->
- [LAB-CHANGE] Updated testing script for deployment pipeline.

## Technical Description

<!--
Provide a clear and concise description of the technical changes.
-->
This change updates the deployment pipeline script to include additional validation steps before pushing to Git. This is part of a lab experiment to improve CI/CD processes.

## Testing Instructions

<!--
Provide step-by-step instructions on how to test the changes.
-->
1. Deploy the updated script in the lab environment.
2. Run a test deployment using the script.
3. Verify that the new validation steps are executed without errors.

## Screenshots

<!--
Include any relevant screenshots, GIFs, or videos to illustrate the changes.
-->

## Checklist

- [ ] I added tests to cover my changes (if applicable).
- [ ] I deployed and verified my code in the lab environment.
- [ ] I checked logs for any side effects or errors.
- [ ] I updated the relevant documentation (if applicable).
- [ ] I reviewed the monitoring tools (Splunk, Datadog) to ensure they reflect the changes.

### Motivation and Context

<!--
Explain why this change was made. 
-->
This change is part of a lab exercise to simulate a production environment and explore improvements to the CI/CD pipeline. The goal is to enhance the deployment process by adding validation steps.
