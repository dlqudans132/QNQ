package room;

public class Room {
	private int roomNumber;
	private String userID;
	private String roomTitle;
	private String roomPassword;
	private int roomCode;
	private String roomJoinCode;
	private int roomAvailable;
	private String roomDate;
	private RoomEncryption encryptRoomPassword;

	public String getRoomDate() {
		return roomDate;
	}

	public void setRoomDate(String roomDate) {
		this.roomDate = roomDate;
	}

	public int getRoomAvailable() {
		return roomAvailable;
	}

	public void setRoomAvailable(int roomAvailable) {
		this.roomAvailable = roomAvailable;
	}

	public int getRoomCode() {
		return roomCode;
	}

	public void setRoomCode(int roomCode) {
		this.roomCode = roomCode;
	}

	public String getRoomJoinCode() {
		return roomJoinCode;
	}

	public void setRoomJoinCode(String roomJoinCode) {
		this.roomJoinCode = roomJoinCode;
	}

	public String getRoomTitle() {
		return roomTitle;
	}

	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}

	

	public String getRoomPassword() {
		return roomPassword;
	}

	public void setRoomPassword(String roomPassword) {
		this.roomPassword = encryptRoomPassword.encrypt(roomPassword);
	}

	public int getRoomNumber() {
		return roomNumber;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}

}
