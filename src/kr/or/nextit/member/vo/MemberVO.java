package kr.or.nextit.member.vo;

public class MemberVO {

	private String memId;
	private String memPass;
	private String memName;
	private String cigarettesPerDay;
	private String memJoinDate;
	private String longestSmokeFreeDate;


	public MemberVO() {
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPass() {
		return memPass;
	}

	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getCigarettesPerDay() {
		return cigarettesPerDay;
	}

	public void setCigarettesPerDay(String cigarettesPerDay) {
		this.cigarettesPerDay = cigarettesPerDay;
	}

	public String getMemJoinDate() {
		return memJoinDate;
	}

	public void setMemJoinDate(String memJoinDate) {
		this.memJoinDate = memJoinDate;
	}

	public String getLongestSmokeFreeDate() {
		return longestSmokeFreeDate;
	}

	public void setLongestSmokeFreeDate(String longestSmokeFreeDate) {
		this.longestSmokeFreeDate = longestSmokeFreeDate;
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPass=" + memPass + ", memName=" + memName + ", cigarettesPerDay="
				+ cigarettesPerDay + ", memJoinDate=" + memJoinDate + ", longestSmokeFreeDate=" + longestSmokeFreeDate
				+ "]";
	}

	public MemberVO(String memId, String memPass, String memName, String cigarettesPerDay, String memJoinDate,
			String longestSmokeFreeDate) {
		super();
		this.memId = memId;
		this.memPass = memPass;
		this.memName = memName;
		this.cigarettesPerDay = cigarettesPerDay;
		this.memJoinDate = memJoinDate;
		this.longestSmokeFreeDate = longestSmokeFreeDate;
	}

}
