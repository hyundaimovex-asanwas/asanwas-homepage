<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.CallableStatement"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String start_ymd = request.getParameter("start_ymd");				//출발일자
	String weekend_yn = request.getParameter("weekend_yn");			//주말여부
	String sel_room_sid = request.getParameter("sel_room_sid");		//선택된 방ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//선택된 호텔명
	String sel_upjang_sid = request.getParameter("sel_upjang_sid");	//선택된 호텔명
	String pinfo = request.getParameter("pinfo");								//예약한고객의 정보
	String room_nm = request.getParameter("room_nm");					//방명
	String foreigner_yn = request.getParameter("foreigner_yn");			//외국인여부

	//예약정보를 담기위한 bean 생성
	Reservation_bean param = new Reservation_bean();

	//예약을 실행할 클래스 생성
	ReservationInfo info = new ReservationInfo();

	String[] person = pinfo.split(",");
	String[] person_detail = null;
	String reg_no = "";									//예약객실정보
	String jumin_no = "";								//주민등록번호
	String age_cd = "";									//나이
	String nm = "";										//이름
	String tel_no = "";									//연락처
	String room_type_sid = "";						//객실SID
	String person_cnt = "";							//해당객실의 인원수

	long price = 0;											//요금
	String cust_sid = "";									//고객ID

	String[] time_info = new String[4];								//시간정보
	String night = "";									//숙박수
	String depart_time = "";							//출발시각
	String arrive_time = "";							//도착시간
	String arrive_date = "";							//도착일자

	String returnMsg = "";								//최종완료Msg

	String prevRoom_type_sid = "";				//이전방 번호
	String prevRoom_seq = "";						//이전방 번호정렬
	String prevPerson_seq = "";					//이전방 사람정렬

	String room_seq = "";
	String person_seq = "";

	int accept_sid = 0;									//신청서ID
	String accept_no = "";								//신청서NO
	int rsv_sid = 0;										//예약SID

	Connection dbconn = info.getCon();
	CallableStatement stpCall = null;
	StringBuffer query = new StringBuffer("");
	query.append("CALL SALES.PR_RV200I_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)");
	
						
	try {
		/*********************************************************************
		**** 예약 프로세스 시작
		*********************************************************************/
		stpCall = dbconn.prepareCall(query.toString()); 
		dbconn.setAutoCommit(false);

		/**************
		* 시간정보 조회 및 저장
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
		* 시간정보 조회 및 저장 끝
		**************/

		for(int i=0 ; i<person.length; i++) {
			
			if(i == 0 ){
				accept_sid = 0;
				accept_no = "";
			} else {
				accept_sid = stpCall.getBigDecimal(1).intValue();
				accept_no = stpCall.getString(2);
			}

			reg_no = person[i].substring(0,11);			//동일한 객실정보를 걸러내기 위해 substring (pinfo_XXX_Y)
			person_detail = person[i].split("_");				//한명의 고객정보에 들어있는 다양한 정보를 저장한다.

			jumin_no = person_detail[5];			//주민등록번호
			nm = person_detail[4];					//이름
			tel_no = person_detail[6];				//연락처
			person_cnt = person_detail[7];		//예약자수(객실)
			room_type_sid = person_detail[1];	//객실SID
			
			room_seq = person_detail[2];			//객실순서
			person_seq = person_detail[3];		//객실예약자순서

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
			* 나이계산
			***********/
			age_cd = info.getAge(foreigner_yn, jumin_no);
			out.println("AGE_CD : "+age_cd+"                 ");
		
			/***********
			* 나이계산 끝
			***********/

			/***********
			*요금계산
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
			*요금계산 끝
			************/		

			/***********
			*고객등록
			************/	
			param.setRegi_no(jumin_no);			//주민등록번호
			param.setCust_nm(nm);					//고객명
			param.setTel_no(tel_no);				//연락처
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
			*고객등록 끝
			************/	
				

			/***********
			* 예약시작
			***********/
			param.setRstdt(start_ymd);						//출발일자
			param.setRscod(goods_sid);						//상품SID
			param.setRoom_type_sid(Integer.parseInt(room_type_sid));	//객실타입
			param.setDepart_time(depart_time);			//출발시간
			param.setDaynight(night);							//숙박일수
			param.setArrive_date(arrive_date);				//도착일
			param.setArrive_time(arrive_time);				//도착시간
			param.setCust_sid(Integer.parseInt(cust_sid));			//고객SID
			param.setAge_cd(age_cd);							//나이
			param.setTel_no(tel_no);							//전화번호
			param.setCust_nm(nm);								//고객명
			param.setWeekend_yn(weekend_yn);			//주말여부
			param.setAccept_sid(accept_sid);				//신청서ID
			param.setAccept_no(accept_no);					//신청서번호
			param.setRsv_sid(rsv_sid);							//예약SID

			returnMsg = info.resvProc(dbconn, stpCall, param);
			/**********
			* 예약 끝
			**********/

		}

		/*********************************************************************
		**** 예약 프로세스 끝
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
