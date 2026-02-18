# Routing Tool Extension - Testing Guide

## Overview
This document provides a comprehensive testing guide for the Routing Tool extension implementation.

## Test Environment Setup
1. Deploy the extension to a Business Central sandbox environment
2. Ensure all AL files compile successfully
3. Verify no compilation errors or warnings

## Test Cases

### Test Case 1: Instruction Table - Create Records
**Objective**: Verify that instruction records can be created and saved

**Steps**:
1. Navigate to "Instructions" list page
2. Click "New" to create a new instruction
3. Enter Code: "INST001"
4. Enter Description: "Test Instruction 1"
5. Save the record

**Expected Results**:
- Record is created successfully
- Code and Description fields are saved
- Record appears in the instruction list

**Status**: ⬜ Not Tested

---

### Test Case 2: Instruction Table - Edit Records
**Objective**: Verify that instruction records can be edited

**Steps**:
1. Open an existing instruction from the list
2. Modify the Description field
3. Save the record

**Expected Results**:
- Changes are saved successfully
- Modified description is displayed in the list

**Status**: ⬜ Not Tested

---

### Test Case 3: Routing Tool Type Field - Default Value
**Objective**: Verify that new Routing Tool entries default to Type = Item

**Steps**:
1. Open Routing Tool table
2. Create a new routing tool entry
3. Check the Type field value

**Expected Results**:
- Type field defaults to "Item"
- No. field lookup shows Item table

**Status**: ⬜ Not Tested

---

### Test Case 4: Conditional TableRelation - Item Type
**Objective**: Verify that when Type = Item, No. field shows Item table lookup

**Steps**:
1. Create/Open a Routing Tool entry
2. Set Type = "Item"
3. Click lookup on No. field

**Expected Results**:
- Lookup shows Item table records
- Can select an item from the list
- Selected item code is saved to No. field

**Status**: ⬜ Not Tested

---

### Test Case 5: Conditional TableRelation - Instruction Type
**Objective**: Verify that when Type = Instruction, No. field shows Instruction table lookup

**Steps**:
1. Create/Open a Routing Tool entry
2. Set Type = "Instruction"
3. Click lookup on No. field

**Expected Results**:
- Lookup shows Instruction table records
- Can select an instruction from the list
- Selected instruction code is saved to No. field

**Status**: ⬜ Not Tested

---

### Test Case 6: Type Change - Clearing No. Field
**Objective**: Verify that changing Type clears the No. field to prevent invalid references

**Steps**:
1. Create a Routing Tool entry with Type = "Item"
2. Select an Item in No. field
3. Change Type to "Instruction"
4. Check No. field value

**Expected Results**:
- No. field is automatically cleared when Type changes
- User must select a new value from Instruction table

**Status**: ⬜ Not Tested

---

### Test Case 7: Type Change - Item to Instruction and Back
**Objective**: Verify that Type can be changed multiple times

**Steps**:
1. Create a Routing Tool entry with Type = "Item"
2. Change Type to "Instruction"
3. Select an instruction
4. Change Type back to "Item"
5. Check No. field

**Expected Results**:
- Type changes are handled correctly
- No. field is cleared each time Type changes
- Appropriate lookup is shown for each Type

**Status**: ⬜ Not Tested

---

### Test Case 8: Backward Compatibility - Existing Records
**Objective**: Verify that existing Routing Tool records continue to work

**Steps**:
1. Review existing Routing Tool entries (if any exist before upgrade)
2. Check Type field value
3. Verify No. field still references correct Item

**Expected Results**:
- Existing records have Type = "Item" (default)
- No. field still correctly references Item table
- No data loss or corruption

**Status**: ⬜ Not Tested

---

### Test Case 9: Data Validation - Required Fields
**Objective**: Verify that required fields are validated

**Steps**:
1. Try to create an Instruction without Code
2. Try to create a Routing Tool entry without required fields

**Expected Results**:
- Appropriate validation errors are shown
- Records cannot be saved without required fields

**Status**: ⬜ Not Tested

---

### Test Case 10: UI Navigation - Card Page Link
**Objective**: Verify that Instruction List links to Card page correctly

**Steps**:
1. Open "Instructions" list page
2. Click on an instruction record

**Expected Results**:
- Instruction Card page opens
- Correct record is displayed
- Can edit fields and save changes

**Status**: ⬜ Not Tested

---

## Integration Testing

### Integration Test 1: Routing Tool Usage in Production Order
**Objective**: Verify that Routing Tool with Instructions works in Production Order context

**Steps**:
1. Create Production Order
2. Add Routing Tool with Type = "Instruction"
3. Select an instruction
4. Verify it displays correctly in production routing

**Expected Results**:
- Instruction-type routing tools work in production context
- No errors when viewing/editing production routing
- Instruction data is displayed correctly

**Status**: ⬜ Not Tested

---

## Performance Testing

### Performance Test 1: Large Instruction List
**Objective**: Verify performance with many instruction records

**Steps**:
1. Create 1000+ instruction records
2. Open Instruction List page
3. Use search/filter functionality
4. Verify page responsiveness

**Expected Results**:
- List page loads within acceptable time
- Search and filter work correctly
- No performance degradation

**Status**: ⬜ Not Tested

---

## Security Testing

### Security Test 1: Data Classification
**Objective**: Verify data classification settings are appropriate

**Steps**:
1. Review DataClassification settings on all fields
2. Verify compliance with GDPR requirements
3. Update ToBeClassified values as needed for production

**Expected Results**:
- All fields have appropriate DataClassification
- No sensitive data is classified incorrectly

**Status**: ⬜ Not Tested (Note: Currently using ToBeClassified - review before production)

---

## Test Summary Template

| Test Case | Status | Date Tested | Tester | Notes |
|-----------|--------|-------------|--------|-------|
| TC1: Create Instruction | ⬜ | | | |
| TC2: Edit Instruction | ⬜ | | | |
| TC3: Default Type Value | ⬜ | | | |
| TC4: Item Type Lookup | ⬜ | | | |
| TC5: Instruction Type Lookup | ⬜ | | | |
| TC6: Type Change Clearing | ⬜ | | | |
| TC7: Multiple Type Changes | ⬜ | | | |
| TC8: Backward Compatibility | ⬜ | | | |
| TC9: Field Validation | ⬜ | | | |
| TC10: Card Page Navigation | ⬜ | | | |
| IT1: Production Order Integration | ⬜ | | | |
| PT1: Large List Performance | ⬜ | | | |
| ST1: Data Classification | ⬜ | | | |

---

## Notes
- All tests should be performed in a sandbox environment before production deployment
- Document any issues found during testing
- Retest after any code changes
- Verify upgrade path from previous version
