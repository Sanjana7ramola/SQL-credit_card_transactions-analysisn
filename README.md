# SQL-credit_card_transactions-analysisn
This project analyzes credit card spending habits in India using a dataset from [Kaggle](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india).
## Dataset

The dataset is available in the `data` folder and is provided as an Excel file:

- **File**: `credit_card_transactions.xlsx`
- **Description**: Contains credit card transaction details for analysis.

## Importing the Dataset into SQL Server

### Using SQL Server Management Studio (SSMS)

1. **Open SQL Server Management Studio (SSMS)**
   - Connect to your SQL Server instance.

2. **Create a New Database (Optional)**
   - Right-click on `Databases` in the Object Explorer.
   - Select `New Database...` and follow the prompts to create a new database if needed.

3. **Import Data Using the Import Wizard**
   - Right-click on the target database (or the database you want to import data into).
   - Select `Tasks` > `Import Data...` to open the SQL Server Import and Export Wizard.
   - Click `Next` to proceed.

4. **Choose Data Source**
   - For the Data Source, select `Microsoft Excel`.
   - Click `Browse` to select the `credit_card_transactions.xlsx` file.
   - Choose the Excel version from the dropdown.
   - Check `First Row has Column Names` if the Excel file has headers.
   - Click `Next`.

5. **Choose Destination**
   - For the Destination, select `SQL Server Native Client`.
   - Provide the connection details for your SQL Server instance.
   - Click `Next`.

6. **Specify Table Copy or Query**
   - Choose `Copy data from one or more tables or views`.
   - Click `Next`.

7. **Select Source Tables and Views**
   - Select the sheet(s) from the Excel file that you want to import.
   - Map them to the target tables in SQL Server.
   - Click `Next`.

8. **Review Data Mapping and Transformations**
   - Review and adjust data mappings if necessary.
   - Click `Next`.

9. **Complete the Wizard**
   - Review the summary of the import operation.
   - Click `Finish` to start the import process.

10. **Check Imported Data**
    - Verify that the data has been imported correctly by querying the target table in SQL Server.
