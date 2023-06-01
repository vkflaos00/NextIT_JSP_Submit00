package kr.or.nextit.member.vo;

public class MemberVO {

	private String memId;
	private String memPass;
	private String memName;
	private String cpd;
	private String joinDate;
	private int dDay;
	private String loveName;
	private int money;
	private int goodCount;

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

	public String getCpd() {
		return cpd;
	}

	public void setCpd(String cpd) {
		this.cpd = cpd;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public int getdDay() {
		return dDay;
	}

	public void setdDay(int dDay) {
		this.dDay = dDay;
	}

	public String getLoveName() {
		return loveName;
	}

	public void setLoveName(String loveName) {
		this.loveName = loveName;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public int getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPass=" + memPass + ", memName=" + memName + ", cpd=" + cpd
				+ ", joinDate=" + joinDate + ", dDay=" + dDay + ", loveName=" + loveName + ", money=" + money
				+ ", goodCount=" + goodCount + "]";
	}

	

}
