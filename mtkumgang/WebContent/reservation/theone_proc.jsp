<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.lang.Exception"%>
<%
	//예약자정보---------------------------------------------
	String rname = request.getParameter("rname");	//예약자명
	String rtel  = request.getParameter("rtel");	//이메일
	String rmob  = request.getParameter("rmob");	//핸드폰
	String rmail = request.getParameter("rmail");	//전화번호
	String rpass = request.getParameter("rpass");	//비밀번호
	//예약자정보---------------------------------------------

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
	String mobile_no = "";									//연락처
	String room_type_sid = "";						//객실SID
	String person_cnt = "";							//해당객실의 인원수

	long price = 0;											//요금
	long tot_price = 0;											//요금
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
	String join_cd ="";	//동숙코드

	int accept_sid = 0;									//신청서ID
	String accept_no = "";								//신청서NO
	int rsv_sid = 0;										//예약SID


    String jumin_noStr 	= new String();	//주민번호
    String nmStr 		= new String();	//이름
    String age_cdStr 	= new String();	//연령
    String mobile_noStr = new String();	//핸폰
    String join_cdStr 	= new String();	//동숙	20090422
    String room_typeStr = new String();	//객실타입


    String dup_yn = "";	 //중복여부	 2009-02-23


	Connection dbconn = info.getCon();
	CallableStatement stpCall = null;
//	StringBuffer query = new StringBuffer("");
//	query.append("CALL SALES.PR_RV200I_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)");
						
	try {
		/*********************************************************************
		**** 예약 프로세스 시작
		*********************************************************************/
//		stpCall = dbconn.prepareCall(query.toString()); 
//		dbconn.setAutoCommit(false);

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

//		out.println("NIGHT : "+night+"<BR>");
//		out.println("depart_time : "+depart_time+"<BR>");
//		out.println("arrive_time : "+arrive_time+"<BR>");
//		out.println("arrive_date : "+arrive_date+"<BR>");

 		/**************
		* 시간정보 조회 및 저장 끝
		**************/

		for(int i=0 ; i<person.length; i++) {
			reg_no = person[i].substring(0,11);			//동일한 객실정보를 걸러내기 위해 substring (pinfo_XXX_Y)
			person_detail = person[i].split("_");				//한명의 고객정보에 들어있는 다양한 정보를 저장한다.

			jumin_no = person_detail[5];			//주민등록번호
			nm = person_detail[4];					//이름
			mobile_no = person_detail[6];				//연락처
			person_cnt = person_detail[7];			//예약자수(객실)
			room_type_sid = person_detail[1];		//객실SID
			
			room_seq = person_detail[2];			//객실순서
			person_seq = person_detail[3];			//객실예약자순서
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

//			out.println("외국인여부 : "+foreigner_yn+"<BR>");
//			out.println("주민/여권 : "+jumin_no+"<BR>");


			/***********
			* 나이계산
			***********/
			age_cd = info.getAge(foreigner_yn, jumin_no);
//			out.println("AGE_CD : "+age_cd+"<BR>");
		
			/***********
			* 나이계산 끝
			***********/


			/**********************
			* 관광객정보의 배열처리
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
			* 관광객정보의 배열처리 끝
			**********************/

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

			price = info.getPrice(param);
			tot_price += info.getPrice(param);//전체요금
//			out.println("PRICE : "+price+"<BR>");
			/***********
			*요금계산 끝
			************/		

			/***********
			*고객등록
			************/	
			param.setRegi_no(jumin_no);			//주민등록번호
			param.setCust_nm(nm);					//고객명
			param.setMobile_no(mobile_no);				//연락처
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
			*고객등록 끝
			************/	

			/***********
			*중복체크 (출발일자, 상품, 고객번호)
			************/	
			param.setRscod(goods_sid);	//상품
			param.setRstdt(start_ymd); //출발일
			param.setCust_sid(Integer.parseInt(cust_sid)); //고객sid
//			out.println("출발일:::"+start_ymd+"<BR>");
//			out.println("고객sid:::"+cust_sid+"<BR>");
//			out.println("상품sid:::"+goods_sid+"<BR>");
			// cust_sid 로 던지고. 원하는 출발일과 중복되는지 여부를 던져서 중복이면 앞페이지로...;
	
			dup_yn = info.getDupYn(param);
//			out.println("dup? : "+ dup_yn +"***<BR>");
			if(dup_yn.equals("Y") ){
				//강제로 오류 발생
				throw new Exception("dup");
			}
		
		
		}
//		out.println("for 문 끝---------------------------------------<BR>");
	
//out.println("jumin_noStr : "+jumin_noStr+"<BR>");
//out.println("nmStr : "+nmStr+"<BR>");
//out.println("age_cdStr : "+age_cdStr+"<BR>");
//out.println("mobile_noStr : "+mobile_noStr+"<BR>");
//out.println("join_cdStr : "+join_cdStr+"<BR>");
//out.println("room_typeStr : "+room_typeStr+"<BR>");




		/***********
		* 예약시작
		***********/
		//예약자 정보 세팅
               param.setRname(rname);//성명
               param.setRmob(rmob);//이동전화번호
			   param.setRtel(rtel);//전화번호
               param.setRmail(rmail);//이메일
               param.setRpass(rpass);//비밀번호
               param.setRstdt(start_ymd); //출발일
               param.setRedt(arrive_date); //도착일
               param.setRstat("1");//예약상태(1:정상)
		//예약자 정보 세팅

		//출발정보 세팅
               param.setNights(night); //박수
               param.setDepart_time(depart_time); //출발시각
               param.setArrive_time(arrive_time); //도착시각

		//저장!
			param.setRscod(goods_sid);	//상품

			//여러명 배열을 돌아주세요...
			// 배열처리 들어가야 함...
                param.setRegi_no(jumin_noStr);//주민번호
                param.setCust_nm(nmStr);//성명
                param.setAge_cd(age_cdStr);//연령코드	 세팅;		빈에 연령코드의 배열을 던지는 구나.. 움;;
				param.setMobile_no(mobile_noStr);//핸폰번호 
				param.setJoin_cd(join_cdStr);//동숙
				param.setRoom_type_str(room_typeStr);//객실타입SID

			//배열
                
                param.setCust_ip(request.getRemoteAddr());//접속아이피

		returnMsg = info.RevInsert(param);			//입력..
		/**********
		* 예약 끝
		**********/




		/*********************************************************************
		**** 예약 프로세스 끝
		*********************************************************************/


	} catch(Exception e) {
		
		//out.println(e);

		if("dup".equals(e.getMessage())){
		%>
		<script language=javascript>
			alert("<%=nm%>(<%=jumin_no%>) 님은\n해당 상품에 이미 예약되어 있습니다.\n다시 확인해주시기 바랍니다.\n\n전 페이지로 이동합니다.");
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
처리중입니다.~
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
