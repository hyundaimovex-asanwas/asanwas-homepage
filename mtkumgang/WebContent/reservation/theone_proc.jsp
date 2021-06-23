<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.lang.Exception"%>
<%
	//����������---------------------------------------------
	String rname = request.getParameter("rname");	//�����ڸ�
	String rtel  = request.getParameter("rtel");	//�̸���
	String rmob  = request.getParameter("rmob");	//�ڵ���
	String rmail = request.getParameter("rmail");	//��ȭ��ȣ
	String rpass = request.getParameter("rpass");	//��й�ȣ
	//����������---------------------------------------------

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
	String mobile_no = "";									//����ó
	String room_type_sid = "";						//����SID
	String person_cnt = "";							//�ش簴���� �ο���

	long price = 0;											//���
	long tot_price = 0;											//���
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
	String join_cd ="";	//�����ڵ�

	int accept_sid = 0;									//��û��ID
	String accept_no = "";								//��û��NO
	int rsv_sid = 0;										//����SID


    String jumin_noStr 	= new String();	//�ֹι�ȣ
    String nmStr 		= new String();	//�̸�
    String age_cdStr 	= new String();	//����
    String mobile_noStr = new String();	//����
    String join_cdStr 	= new String();	//����	20090422
    String room_typeStr = new String();	//����Ÿ��


    String dup_yn = "";	 //�ߺ�����	 2009-02-23


	Connection dbconn = info.getCon();
	CallableStatement stpCall = null;
//	StringBuffer query = new StringBuffer("");
//	query.append("CALL SALES.PR_RV200I_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)");
						
	try {
		/*********************************************************************
		**** ���� ���μ��� ����
		*********************************************************************/
//		stpCall = dbconn.prepareCall(query.toString()); 
//		dbconn.setAutoCommit(false);

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

//		out.println("NIGHT : "+night+"<BR>");
//		out.println("depart_time : "+depart_time+"<BR>");
//		out.println("arrive_time : "+arrive_time+"<BR>");
//		out.println("arrive_date : "+arrive_date+"<BR>");

 		/**************
		* �ð����� ��ȸ �� ���� ��
		**************/

		for(int i=0 ; i<person.length; i++) {
			reg_no = person[i].substring(0,11);			//������ ���������� �ɷ����� ���� substring (pinfo_XXX_Y)
			person_detail = person[i].split("_");				//�Ѹ��� �������� ����ִ� �پ��� ������ �����Ѵ�.

			jumin_no = person_detail[5];			//�ֹε�Ϲ�ȣ
			nm = person_detail[4];					//�̸�
			mobile_no = person_detail[6];				//����ó
			person_cnt = person_detail[7];			//�����ڼ�(����)
			room_type_sid = person_detail[1];		//����SID
			
			room_seq = person_detail[2];			//���Ǽ���
			person_seq = person_detail[3];			//���ǿ����ڼ���
			if(person_seq.equals("0")){
				join_cd="01";
			}else{
				join_cd="02";
			}

			if(prevRoom_type_sid.equals("") && prevRoom_seq.equals("")) {
				prevRoom_type_sid = room_type_sid;
				prevRoom_seq = room_seq;
				rsv_sid = 0;
			} else {
				if(!prevRoom_type_sid.equals(room_type_sid) || !prevRoom_seq.equals(room_seq)) {
					rsv_sid = 0;
				} else {
					//rsv_sid = stpCall.getBigDecimal(9).intValue();
				}
			}

//			out.println("�ܱ��ο��� : "+foreigner_yn+"<BR>");
//			out.println("�ֹ�/���� : "+jumin_no+"<BR>");


			/***********
			* ���̰��
			***********/
			age_cd = info.getAge(foreigner_yn, jumin_no);
//			out.println("AGE_CD : "+age_cd+"<BR>");
		
			/***********
			* ���̰�� ��
			***********/


			/**********************
			* ������������ �迭ó��
			**********************/
            if(i > 0){
                    jumin_noStr = jumin_noStr+","+jumin_no;
                    nmStr 		= nmStr+","+nm;
                    age_cdStr 	= age_cdStr+","+age_cd;
					mobile_noStr= mobile_noStr+","+mobile_no;
					join_cdStr	= join_cdStr+","+join_cd;
					room_typeStr= room_typeStr+","+room_type_sid;
            }else{
                    jumin_noStr = jumin_no;
                    nmStr 		= nm;
                    age_cdStr 	= age_cd;
					mobile_noStr= mobile_no;
					join_cdStr	= join_cd;
					room_typeStr= room_type_sid;
            }
			/**********************
			* ������������ �迭ó�� ��
			**********************/

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

			price = info.getPrice(param);
			tot_price += info.getPrice(param);//��ü���
//			out.println("PRICE : "+price+"<BR>");
			/***********
			*��ݰ�� ��
			************/		

			/***********
			*�����
			************/	
			param.setRegi_no(jumin_no);			//�ֹε�Ϲ�ȣ
			param.setCust_nm(nm);					//����
			param.setMobile_no(mobile_no);				//����ó
			if(foreigner_yn.equals("N")) {
				param.setForeigner_cd("10");
			} else {
				param.setForeigner_cd("40");
			}

//			out.println("REGI_NO : "+jumin_no+"<BR>");
//			out.println("CUST_NM : "+nm+"<BR>");
//			out.println("mobile_no : "+ mobile_no+"<BR>");
//			out.println("CUST_SID : "+cust_sid+"<BR>");
			cust_sid = info.getCustId(param);
			/***********
			*����� ��
			************/	

			/***********
			*�ߺ�üũ (�������, ��ǰ, ����ȣ)
			************/	
			param.setRscod(goods_sid);	//��ǰ
			param.setRstdt(start_ymd); //�����
			param.setCust_sid(Integer.parseInt(cust_sid)); //��sid
//			out.println("�����:::"+start_ymd+"<BR>");
//			out.println("��sid:::"+cust_sid+"<BR>");
//			out.println("��ǰsid:::"+goods_sid+"<BR>");
			// cust_sid �� ������. ���ϴ� ����ϰ� �ߺ��Ǵ��� ���θ� ������ �ߺ��̸� ����������...;
	
			dup_yn = info.getDupYn(param);
//			out.println("dup? : "+ dup_yn +"***<BR>");
			if(dup_yn.equals("Y") ){
				//������ ���� �߻�
				throw new Exception("dup");
			}
		
		
		}
//		out.println("for �� ��---------------------------------------<BR>");
	
//out.println("jumin_noStr : "+jumin_noStr+"<BR>");
//out.println("nmStr : "+nmStr+"<BR>");
//out.println("age_cdStr : "+age_cdStr+"<BR>");
//out.println("mobile_noStr : "+mobile_noStr+"<BR>");
//out.println("join_cdStr : "+join_cdStr+"<BR>");
//out.println("room_typeStr : "+room_typeStr+"<BR>");




		/***********
		* �������
		***********/
		//������ ���� ����
               param.setRname(rname);//����
               param.setRmob(rmob);//�̵���ȭ��ȣ
			   param.setRtel(rtel);//��ȭ��ȣ
               param.setRmail(rmail);//�̸���
               param.setRpass(rpass);//��й�ȣ
               param.setRstdt(start_ymd); //�����
               param.setRedt(arrive_date); //������
               param.setRstat("1");//�������(1:����)
		//������ ���� ����

		//������� ����
               param.setNights(night); //�ڼ�
               param.setDepart_time(depart_time); //��߽ð�
               param.setArrive_time(arrive_time); //�����ð�

		//����!
			param.setRscod(goods_sid);	//��ǰ

			//������ �迭�� �����ּ���...
			// �迭ó�� ���� ��...
                param.setRegi_no(jumin_noStr);//�ֹι�ȣ
                param.setCust_nm(nmStr);//����
                param.setAge_cd(age_cdStr);//�����ڵ�	 ����;		�� �����ڵ��� �迭�� ������ ����.. ��;;
				param.setMobile_no(mobile_noStr);//������ȣ 
				param.setJoin_cd(join_cdStr);//����
				param.setRoom_type_str(room_typeStr);//����Ÿ��SID

			//�迭
                
                param.setCust_ip(request.getRemoteAddr());//���Ӿ�����

		returnMsg = info.RevInsert(param);			//�Է�..
		/**********
		* ���� ��
		**********/




		/*********************************************************************
		**** ���� ���μ��� ��
		*********************************************************************/


	} catch(Exception e) {
		
		//out.println(e);

		if("dup".equals(e.getMessage())){
		%>
		<script language=javascript>
			alert("<%=nm%>(<%=jumin_no%>) ����\n�ش� ��ǰ�� �̹� ����Ǿ� �ֽ��ϴ�.\n�ٽ� Ȯ�����ֽñ� �ٶ��ϴ�.\n\n�� �������� �̵��մϴ�.");
			window.history.back();
		</script>
		<%
		}
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

<body>
ó�����Դϴ�.~
<form name="resv" method="post">
	<input type="hidden" name="rname" value="<%=rname%>">
	<input type="hidden" name="rmail" value="<%=rmail%>">
	<input type="hidden" name="rpass" value="<%=rpass%>">

	<input type="hidden" name="goods_sid" value="<%=goods_sid%>">
	<input type="hidden" name="member" value="<%=person.length%>">
	<input type="hidden" name="total_price" value="<%=tot_price%>">


</form>
</body>

<script language=javascript>
	document.resv.action = "theone_step6.jsp";
	document.resv.submit();
</script>
