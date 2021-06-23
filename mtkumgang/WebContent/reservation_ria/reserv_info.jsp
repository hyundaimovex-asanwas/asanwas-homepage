<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.RiaReservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.RiaReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page buffer="0"%>
<%
    String op = new String();
    StringBuffer sb = new StringBuffer("");
    
    String userId = ParamUtil.getReqParameter(request.getParameter("userId"));//예약자ID, 회원인경우는 not null
    String email = ParamUtil.getReqParameter(request.getParameter("email"));//예약자Email
    String pwd = ParamUtil.getReqParameter(request.getParameter("pwd"));//예약자password
    String name = ParamUtil.getReqParameter(request.getParameter("name"));//예약자이름
    String tel = ParamUtil.getReqParameter(request.getParameter("tel"));//예약자 연락처
    String startYear = ParamUtil.getReqParameter(request.getParameter("startYear"));
    String startMonth = ParamUtil.getReqParameter(request.getParameter("startMonth"));
    String startDay = ParamUtil.getReqParameter(request.getParameter("startDay"));
    String endYear = ParamUtil.getReqParameter(request.getParameter("endYear"));
    String endMonth = ParamUtil.getReqParameter(request.getParameter("endMonth"));
    String endDay = ParamUtil.getReqParameter(request.getParameter("endDay"));    
    String goods = ParamUtil.getReqParameter(request.getParameter("goods")).trim(); //예약상품코드
    String reservDate = new String();
    String arriveDate = new String();
    String DbMesage = new String();
    
    sb.append("userId : " + userId + "\n");
    sb.append("email : " + email + "\n");
    sb.append("pwd : " + pwd + "\n");
    sb.append("name : " + name + "\n");
    sb.append("tel : " + tel + "\n");
    sb.append("goods : " + goods + "\n");


    startMonth = startMonth.length()==1 ? "0" + startMonth:startMonth;
    endMonth = endMonth.length()==1 ? "0" + endMonth:endMonth;
    startDay = startDay.length()==1 ? "0" + startDay:startDay;
    endDay = endDay.length()==1 ? "0" + endDay:endDay;

    
    reservDate = startYear + startMonth + startDay; // 출발일
    arriveDate = endYear + endMonth + endDay; // 도착일
    
    sb.append("reservDate : " + reservDate + "\n");

    int roomCnt = Util.parseInt(request.getParameter("roomCnt"), 0); //예약 객실 갯수

    sb.append("roomCnt : " + String.valueOf(roomCnt) + "\n");
    
    int guestCnt = 0; //각 객실 투숙 여행자 수(임시)
    
    int upjangSid = 0;//각 숙소 sid
    int roomTypeSid = 0;//각 객실타입 sid
    
    String guestName = new String();
    String guestJuminNo = new String();
    String guestGubun = new String();
	String guestJoin = new String();				//동숙구분	변수
    String guestPrice = new String();
    String guestNameStr = new String();
    String guestJuminNoStr = new String();
    String guestGubunStr = new String();
    String guestJoinStr = new String();			//동숙구분	배열
    
    for (int i = 0;i < roomCnt; i++)
    {
        upjangSid = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_upjangSid"), 0);
        roomTypeSid = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_roomTypeSid"), 0);
        guestCnt = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_guestCnt"), 0);
        
        sb.append("upjangSid_" + String.valueOf(i) + " : " + String.valueOf(upjangSid) + "\n");
        sb.append("roomTypeSid_" + String.valueOf(i) + " : " + String.valueOf(roomTypeSid) + "\n");
        sb.append("guestCnt_" + String.valueOf(i) + " : " + String.valueOf(guestCnt) + "\n");
        
        for(int j = 0 ; j< guestCnt ; j++)	//1객실 당 고객 수
        {
             
            guestName = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_name")); //투숙객 이름
            guestJuminNo = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_juminNo"));//투숙객 주민번호
            guestGubun = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_gubun"));//투숙객 구분 (성인,고등학생,중학생....)
            guestPrice = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_price"));//투숙객 요금
            guestPrice = guestPrice.replaceAll(",","");

            sb.append("guestName_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestName + "\n");
            sb.append("guestJuminNo_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestJuminNo + "\n");
            sb.append("guestGubun_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestGubun + "\n");
            sb.append("guestPrice_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestPrice + "\n");
            
			//조인코드 세팅
			if(j==0){
				guestJoin = "01";		//본인
			}else{
				guestJoin = "02";		//지인
			};


			//스트링 만들기
            if(j > 0){
                    guestNameStr = guestNameStr+","+guestName;
                    guestJuminNoStr = guestJuminNoStr+","+guestJuminNo;
                    guestGubunStr = guestGubunStr+","+guestGubun;
					guestJoinStr = guestJoinStr+","+guestJoin;
            }else{
                    guestNameStr = guestName;
                    guestJuminNoStr = guestJuminNo;
                    guestGubunStr = guestGubun;
					guestJoinStr = guestJoin;
            }

            
        }
        
        
            /*여행자 정보 insert start*/
          
                Reservation_bean bean = new Reservation_bean();
                ReservationInfo dao = new ReservationInfo();
                
                bean.setRname(name);//성명
                bean.setRmob(tel);//이동전화번호
                bean.setRmail(email);//이메일
                bean.setRpass(pwd);//비밀번호
                bean.setRstdt(reservDate); //출발일
                bean.setRedt(arriveDate); //도착일
                bean.setRstat("1");//예약상태(1:정상)
                
                
                //if  (goods == "1111201" ){//1박
                //    goods = "27";
                //}else{//2박
                //    goods = "28";
                //}
                
                if  (goods == "1111200" || goods.equals("1111200")){//1박
                    goods = "27";
                }else{//2박
                    goods = "28";
                } 
            
            
                bean.setRscod(goods);//숙박수
                //System.out.println("-------------------guestJuminNoStr------------------------------------------"+guestJuminNoStr);
                //System.out.println("-------------------guestNameStr------------------------------------------"+guestNameStr);
                //System.out.println("-------------------guestGubunStr------------------------------------------"+guestGubunStr);
                
                //guestJuminNoStr = "8112172222222";
                
                bean.setRegi_no(guestJuminNoStr);//주민번호
                bean.setCust_nm(guestNameStr);//성명
                bean.setAge_cd(guestGubunStr);//연령코드	 : 연령코드 세팅;;;;
				bean.setJoin_cd(guestJoinStr);//동숙코드	 : 동숙코드 세팅;;;;

                
                bean.setCust_ip(request.getRemoteAddr());//접속아이피
                bean.setUpjang_sid(upjangSid);//객실타입 'HHSTT'
                bean.setRoom_type_sid(roomTypeSid);//객실타입SID
                DbMesage = dao.RevInsert(bean);
                
            /*여행자 정보 insert end*/
                    
    }
    
    System.out.println("-------------------DbMesage----------------------"+DbMesage);
    
    String result = "";
    String message = "";
    StringTokenizer tokens = new StringTokenizer(DbMesage, "|" ); 
    String [] arrStr = new String[tokens.countTokens()];
    //System.out.println("--------------------arrStr1-------------"+tokens.nextToken());
    //System.out.println("--------------------arrStr2-------------"+tokens.nextToken());
    
    message = tokens.nextToken();
    result = tokens.nextToken();
    
   // if( !result.equals("N")){
     
     op = sb.toString();
     
     //result = new String(result);//insert 결과값 , OK = "Y" Error = "N"
     
     String comment = new String();//result == "N" 일 경우의 이유
     out.println("&result=" + result + "&comment="+ message + "&op=" + URLEncoder.encode(op));
     
   // }else{
    //}
    
%>