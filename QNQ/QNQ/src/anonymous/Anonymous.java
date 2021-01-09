package anonymous;

public class Anonymous {
	private String anonymousID;
	private String anonymousDate;
	private int roomCode;
	private int anonymousCnt;
	private String anonymousNickname;

	public int getAnonymousCnt() {
		return anonymousCnt;
	}

	public void setAnonymousCnt(int anonymousCnt) {
		this.anonymousCnt = anonymousCnt;
	}

	public String getAnonymousID() {
		return anonymousID;
	}

	public void setAnonymousID(String anonymousID) {
		this.anonymousID = anonymousID;
	}

	public String getAnonymousDate() {
		return anonymousDate;
	}

	public void setAnonymousDate(String anonymousDate) {
		this.anonymousDate = anonymousDate;
	}

	public int getRoomCode() {
		return roomCode;
	}

	public void setRoomCode(int roomCode) {
		this.roomCode = roomCode;
	}

	public String getAnonymousNickname() {
		return anonymousNickname;
	}

	public void setAnonymousNickname(String anonymousNickname) {
		this.anonymousNickname = anonymousNickname;
	}

}
