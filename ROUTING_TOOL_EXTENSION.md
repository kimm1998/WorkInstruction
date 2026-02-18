# Routing Tool Extension Implementation

## Overview
This implementation extends the base Routing Tool table (Table 99000802) in Business Central to support different types of routing entries with conditional table relations.

## Files Created

### 1. Enum50555.RoutingToolType.al
- **Purpose**: Defines the Type enum for Routing Tool entries
- **Values**: 
  - `Item` (0)
  - `Instruction` (1)
- **Features**: Extensible for future additions

### 2. Tab50563.Instruction.al
- **Purpose**: Master data table for storing work instructions
- **Fields**:
  - `Code` (Code[20]) - Primary Key
  - `Description` (Text[100])
- **Usage**: Stores instruction records that can be referenced from Routing Tool

### 3. Pag50596.InstructionList.al
- **Purpose**: List page for managing instruction records
- **Features**:
  - List view of all instructions
  - Links to Instruction Card for detailed editing
  - Available in the Lists category

### 4. Pag50597.InstructionCard.al
- **Purpose**: Card page for detailed instruction data entry
- **Features**:
  - Single record view
  - Editable Code and Description fields

### 5. Tab-Ext50564.RoutingTool.al
- **Purpose**: Extends the base Routing Tool table with Type field and conditional relations
- **Key Features**:
  - **Type Field**: Enum field with default value `Item` for backward compatibility
  - **Conditional TableRelation**: Modifies the `No.` field to have dynamic table relations based on Type:
    - When Type = Item: Links to Item table (Table 27)
    - When Type = Instruction: Links to Instruction table
  - **OnValidate Trigger**: Clears the `No.` field when Type changes to prevent invalid references

## Technical Implementation

### Conditional Table Relations
The implementation uses AL's conditional TableRelation syntax:
```al
TableRelation = if (Type = const(Item)) Item
                else
                if (Type = const(Instruction)) Instruction;
```

This ensures:
- Data integrity through proper foreign key relationships
- Type-specific lookup functionality
- Prevention of invalid references

### Backward Compatibility
- The Type field defaults to `Item` ensuring existing records continue to work
- No changes required to existing data
- Existing functionality remains intact

## Usage

### Adding Instructions
1. Navigate to "Instructions" list page
2. Create new instruction records with Code and Description
3. These instructions can now be referenced from Routing Tool entries

### Using Routing Tool with Instructions
1. Open Routing Tool entry
2. Set Type field to "Instruction"
3. Select an instruction from the No. field (will show lookup to Instruction table)
4. Or set Type to "Item" to select from Item table (default behavior)

## ID Allocation
All objects use IDs within the allocated range (50500-50600):
- Table: 50563
- Table Extension: 50564
- Enum: 50555
- Pages: 50596, 50597

## Notes
- DataClassification is set to `ToBeClassified` to match existing codebase conventions
- Before production deployment, review and update DataClassification values according to GDPR requirements
- The enum is marked as Extensible to allow future additions of new types
