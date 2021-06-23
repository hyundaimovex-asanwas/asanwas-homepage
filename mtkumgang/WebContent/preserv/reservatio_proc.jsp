<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.CallableStatement"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//������ǰ �ڵ�
	String saup_sid = request.getParameter("saup_sid");					//������ �ڵ�
	String start_ymd = request.getParameter("start_ymd");				//�������
	String weekend_yn = request.getParameter("weekend_yn");			//�ָ�����
	String sel_room_sid = request.getParameter("sel_room_sid");		//���õ� ��ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//���õ� ȣ�ڸ�
	String sel_upjang_sid = request.getParameter("sel_upjang_sid");	//���õ� ȣ�ڸ�
	String pinfo = request.getParameter("pinfo");								//�����Ѱ��� ����
	String room_nm = request.getParameter("room_nm");					//���
	String foreigner_yn = request.getParameter("foreigner_yn");			//�ܱ��ο���

	//���������� ������� bean ����
	Reservation_bean param = new Reservation_bean();

	//������ ������ Ŭ���� ����
	ReservationInfo info = new ReservationInfo();

	String[] person = pinfo.split(",");
	String[] person_detail = null;
	String reg_no = "";									//���ఴ������
	String jumin_no = "";								//�ֹε�Ϲ�ȣ
	String age_cd = "";									//����
	String nm = "";										//�̸�
	String tel_no = "";									//����ó
	String room_type_sid = "";						//����SID
	String person_cnt = "";							//�ش簴���� �ο���

	long price = 0;											//���
	String cust_sid = "";									//��ID

	String[] time_info = new String[4];								//�ð�����
	String night = "";									//���ڼ�
	String depart_time = "";							//��߽ð�
	String arrive_time = "";							//�����ð�
	String arrive_date = "";							//��������

	String returnMsg = "";								//�����Ϸ�Msg

	String prevRoom_type_sid = "";				//������ ��ȣ
	String prevRoom_seq = "";						//������ ��ȣ����
	String prevPerson_seq = "";					//������ �������

	String room_seq = "";
	String person_seq = "";

	int accept_sid = 0;									//��û��ID
	String accept_no = "";								//��û��NO
	int rsv_sid = 0;										//����SID

	Connection dbconn = info.getCon();
	CallableStatement stpCall = null;
	StringBuffer query = new StringBuffer("");
	query.append("CALL SALES.PR_RV200I_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)");
	
						
	try {
		/*********************************************************************
		**** ���� ���μ��� ����
		*********************************************************************/
		stpCall = dbconn.prepareCall(query.toString()); 
		dbconn.setAutoCommit(false);

		/**************
		* �ð����� ��ȸ �� ����
		**************/
		param.setDepart_date(start_ymd);
		param.setGoods_cd(goods_sid);

		time_info = info.getTimeInfo(param);

		night = time_info[0];
		depart_time = time_info[1];
		arrive_time = time_info[2];
		arrive_date = time_info[3];

		out.println("NIGHT : "+night);
		out.println("depart_time : "+depart_time);
		out.println("arrive_time : "+arrive_time);
		out.println("arrive_date : "+arrive_date);

 		/**************
		* �ð����� ��ȸ �� ���� ��
		**************/

		for(int i=0 ; i<person.length; i++) {
			
			if(i == 0 ){
				accept_sid = 0;
				accept_no = "";
			} else {
				accept_sid = stpCall.getBigDecimal(1).intValue();
				accept_no = stpCall.getString(2);
			}

			reg_no = person[i].substring(0,11);			//������ ���������� �ɷ����� ���� substring (pinfo_XXX_Y)
			person_detail = person[i].split("_");				//�Ѹ��� �������� ����ִ� �پ��� ������ �����Ѵ�.

			jumin_no = person_detail[5];			//�ֹε�Ϲ�ȣ
			nm = person_detail[4];					//�̸�
			tel_no = person_detail[6];				//����ó
			person_cnt = person_detail[7];		//�����ڼ�(����)
			room_type_sid = person_detail[1];	//����SID
			
			room_seq = person_detail[2];			//���Ǽ���
			person_seq = person_detail[3];		//���ǿ����ڼ���

			if(prevRoom_type_sid.equals("") && prevRoom_seq.equals("")) {
				prevRoom_type_sid = room_type_sid;
				prevRoom_seq = room_seq;
				rsv_sid = 0;
			} else {
				if(!prevRoom_type_sid.equals(room_type_sid) || !prevRoom_seq.equals(room_seq)) {
					rsv_sid = 0;
				} else {
					rsv_sid = stpCall.getBigDecimal(9).intValue();
				}
			}

			out.println(foreigner_yn);
			out.println(jumin_no);
			/***********
			* ���̰��
			***********/
			age_cd = info.getAge(foreigner_yn, jumin_no);
			out.println("AGE_CD : "+age_cd+"                 ");
		
			/***********
			* ���̰�� ��
			***********/

			/***********
			*��ݰ��
			************/
			param.setSaup_sid(saup_sid);
			param.setGoods_cd(goods_sid);
			param.setDepart_date(start_ymd);
			param.setUpjang_sid(Integer.parseInt(sel_upjang_sid));
			param.setRoom_type_sid(Integer.parseInt(room_type_sid));
			param.setAge_cd(age_cd);
			param.setPerson_cnt(person_cnt);

			price += info.getPrice(param);
			out.println("PRICE : "+price+"\n");
			/***********
			*��ݰ�� ��
			************/		

			/***********
			*�����
			************/	
			param.setRegi_no(jumin_no);			//�ֹε�Ϲ�ȣ
			param.setCust_nm(nm);					//����
			param.setTel_no(tel_no);				//����ó
			if(foreigner_yn.equals("N")) {
				param.setForeigner_cd("10");
			} else {
				param.setForeigner_cd("40");
			}

			out.println("REGI_NO : "+jumin_no);
			out.println("CUST_NM : "+nm);
			out.println("TEL_NO : "+ tel_no);
			cust_sid = info.getCustId(param);
			out.println("CUST_SID : "+cust_sid+"\n");
			/***********
			*����� ��
			************/	
				

			/***********
			* �������
			***********/
			param.setRstdt(start_ymd);						//�������
			param.setRscod(goods_sid);						//��ǰSID
			param.setRoom_type_sid(Integer.parseInt(room_type_sid));	//����Ÿ��
			param.setDepart_time(depart_time);			//��߽ð�
			param.setDaynight(night);							//�����ϼ�
			param.setArrive_date(arrive_date);				//������
			param.setArrive_time(arrive_time);				//�����ð�
			param.setCust_sid(Integer.parseInt(cust_sid));			//��SID
			param.setAge_cd(age_cd);							//����
			param.setTel_no(tel_no);							//��ȭ��ȣ
			param.setCust_nm(nm);								//����
			param.setWeekend_yn(weekend_yn);			//�ָ�����
			param.setAccept_sid(accept_sid);				//��û��ID
			param.setAccept_no(accept_no);					//��û����ȣ
			param.setRsv_sid(rsv_sid);							//����SID

			returnMsg = info.resvProc(dbconn, stpCall, param);
			/**********
			* ���� ��
			**********/

		}

		/*********************************************************************
		**** ���� ���μ��� ��
		*********************************************************************/
		dbconn.rollback();
	} catch(Exception e) {
		dbconn.rollback();
		out.println(e);
	} finally {
		try {
			if(stpCall != null) {
				stpCall.close();
			}
		} catch(Exception e) {}
	    try {
			if(dbconn != null) {
				dbconn.close();
			}
		} catch(Exception e) {} 
	    
	}
%>
