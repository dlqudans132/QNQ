package user;

public class User {
	private String userID;
	private String userPassword;
	private String userDate;
	private UserEncrypiton encryptUserPassword;

	public String getUserDate() {
		return userDate;
	}

	public void setUserDate(String userDate) {
		this.userDate = userDate;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = encryptUserPassword.encrypt(userPassword);
	}


}
