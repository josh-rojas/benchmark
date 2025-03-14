# CLAUDE.md - Benchmarking App Guidelines

## Build/Deploy Commands
- Deploy to org: `sf project deploy start`
- Push to scratch org: `sf project deploy start -o your-org-alias`
- Retrieve from org: `sf project retrieve start`
- Create scratch org: `sf org create scratch -f config/project-scratch-def.json -a YourAlias`

## Test Commands
- Run all LWC tests: `npm run test:unit`
- Run LWC tests in watch mode: `npm run test:unit:watch`
- Debug LWC tests: `npm run test:unit:debug`
- Test coverage: `npm run test:unit:coverage`
- Run single LWC test: `sfdx-lwc-jest path/to/test/file.test.js`
- Run Apex tests: `sf apex test run -y`
- Run single Apex test: `sf apex test run -t TestClassName`

## Lint/Format
- Lint LWC: `npm run lint`
- Format all files: `npm run prettier`
- Verify formatting: `npm run prettier:verify`

## Code Style Guidelines
- Use Prettier for formatting (configured for Apex, LWC, XML, etc.)
- Follow Salesforce Lightning Web Component best practices
- Use camelCase for JavaScript variables and functions
- Use PascalCase for classes and components
- Maintain proper JSDoc comments for functions and classes
- Use explicit typing where possible in Apex and TypeScript