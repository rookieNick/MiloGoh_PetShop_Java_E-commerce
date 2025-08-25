
package Exception;


public class Password {
    private String passwordStr;
    
    public Password(String passwordStr) throws InvalidPasswordException {
        if ((passwordStr == null) || passwordStr.length() < 7) {
            throw new InvalidPasswordException("Invalid password: Password must be at least 7 characters long");
        }
        
        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;
        
        for (int i = 0; i < passwordStr.length(); i++) {
            char ch = passwordStr.charAt(i);
            if (Character.isUpperCase(ch)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(ch)) {
                hasLowerCase = true;
            } else if (Character.isDigit(ch)) {
                hasDigit = true;
            } else if (!Character.isLetterOrDigit(ch)) {
                hasSpecialChar = true;
            }
        }
        
        if (!(hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar)) {
            throw new InvalidPasswordException("Invalid password: Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character");
        }
        
        this.passwordStr = passwordStr;
    }
}
