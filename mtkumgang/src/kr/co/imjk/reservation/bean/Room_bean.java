package kr.co.imjk.reservation.bean;

public class Room_bean {

	private String start_ymd;					//�������
	private String saup_sid;					//�����ID
	private String goods_sid;					//��ǰID
	
	private String upjang_sid;					//����ID
	private String upjang_nm;					//���Ҹ�
	private String upjang_eng_nm;				//���ҿ�����
	private String rsv_yn;						//���뿩��
		
	private String room_type_sid;				//��ID
	
	private String room_type_nm;				//���
	private String cnt;							//����
	private String display_seq;					//���ļ���
	private String double_1;					//����
	private String max_p;						//���ִ��ο�
	
	private String room_type_eng_nm;			//�������
	
	
	public String getUpjang_eng_nm() {
		return upjang_eng_nm;
	}
	public void setUpjang_eng_nm(String upjang_eng_nm) {
		this.upjang_eng_nm = upjang_eng_nm;
	}
	public String getRoom_type_eng_nm() {
		return room_type_eng_nm;
	}
	public void setRoom_type_eng_nm(String room_type_eng_nm) {
		this.room_type_eng_nm = room_type_eng_nm;
	}
	public String getDouble_1() {
		return double_1;
	}
	public void setDouble_1(String double_1) {
		this.double_1 = double_1;
	}
	public String getMax_p() {
		return max_p;
	}
	public void setMax_p(String max_p) {
		this.max_p = max_p;
	}
	public String getDisplay_seq() {
		return display_seq;
	}
	public void setDisplay_seq(String display_seq) {
		this.display_seq = display_seq;
	}
	public String getRoom_type_sid() {
		return room_type_sid;
	}
	public void setRoom_type_sid(String room_type_sid) {
		this.room_type_sid = room_type_sid;
	}
	public String getRoom_type_nm() {
		return room_type_nm;
	}
	public void setRoom_type_nm(String room_type_nm) {
		this.room_type_nm = room_type_nm;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getStart_ymd() {
		return start_ymd;
	}
	public void setStart_ymd(String start_ymd) {
		this.start_ymd = start_ymd;
	}
	public String getSaup_sid() {
		return saup_sid;
	}
	public void setSaup_sid(String saup_sid) {
		this.saup_sid = saup_sid;
	}
	public String getGoods_sid() {
		return goods_sid;
	}
	public void setGoods_sid(String goods_sid) {
		this.goods_sid = goods_sid;
	}
	public String getUpjang_sid() {
		return upjang_sid;
	}
	public void setUpjang_sid(String upjang_sid) {
		this.upjang_sid = upjang_sid;
	}
	public String getUpjang_nm() {
		return upjang_nm;
	}
	public void setUpjang_nm(String upjang_nm) {
		this.upjang_nm = upjang_nm;
	}
	public String getRsv_yn() {
		return rsv_yn;
	}
	public void setRsv_yn(String rsv_yn) {
		this.rsv_yn = rsv_yn;
	}
	
	
}
