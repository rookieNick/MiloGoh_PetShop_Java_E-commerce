
package control;

import da.AccountDA;
import domain.Account;
import java.util.ArrayList;

public class MaintainAccountControl {

    private AccountDA accountDA;

    public MaintainAccountControl() {
        accountDA = new AccountDA();
    }

    public Account selectRecord(String accountID) {
        return accountDA.getRecord(accountID);
    }

    public void addRecord(Account account) {
        accountDA.addRecord(account);
    }

    public void editRecord(Account account) {
        accountDA.editRecord(account);
    }

    public void deleteRecord(Account account) {
        accountDA.deleteRecord(account);
    }
    
    public Account getLogin(String username, String password) {
        return accountDA.loginValidation(username,password);
    }
    
    public Account newStaffGetLogin(String staffId, String password) {
        return accountDA.newStaffLoginValidation(staffId,password);
    }
    
    public ArrayList<Account> getAllCertainRecords(String position) {
        return accountDA.getAllCertainRecords(position);
    }
    
    public Account selectAccuntFromGmail(String gmail) {
        return accountDA.findAccountFromGmail(gmail);
    }
    
    public ArrayList<Account> selectAllAccuntFromStatus(String status) {
        return accountDA.getAllAccountFromStatus(status);
    }
}
