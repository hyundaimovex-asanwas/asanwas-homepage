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
    
    String userId = ParamUtil.getReqParameter(request.getParameter("userId"));//������ID, ȸ���ΰ��� not null
    String email = ParamUtil.getReqParameter(request.getParameter("email"));//������Email
    String pwd = ParamUtil.getReqParameter(request.getParameter("pwd"));//������password
    String name = ParamUtil.getReqParameter(request.getParameter("name"));//�������̸�
    String tel = ParamUtil.getReqParameter(request.getParameter("tel"));//������ ����ó
    String startYear = ParamUtil.getReqParameter(request.getParameter("startYear"));
    String startMonth = ParamUtil.getReqParameter(request.getParameter("startMonth"));
    String startDay = ParamUtil.getReqParameter(request.getParameter("startDay"));
    String endYear = ParamUtil.getReqParameter(request.getParameter("endYear"));
    String endMonth = ParamUtil.getReqParameter(request.getParameter("endMonth"));
    String endDay = ParamUtil.getReqParameter(request.getParameter("endDay"));    
    String goods = ParamUtil.getReqParameter(request.getParameter("goods")).trim(); //�����ǰ�ڵ�
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

    
    reservDate = startYear + startMonth + startDay; // �����
    arriveDate = endYear + endMonth + endDay; // ������
    
    sb.append("reservDate : " + reservDate + "\n");

    int roomCnt = Util.parseInt(request.getParameter("roomCnt"), 0); //���� ���� ����

    sb.append("roomCnt : " + String.valueOf(roomCnt) + "\n");
    
    int guestCnt = 0; //�� ���� ���� ������ ��(�ӽ�)
    
    int upjangSid = 0;//�� ���� sid
    int roomTypeSid = 0;//�� ����Ÿ�� sid
    
    String guestName = new String();
    String guestJuminNo = new String();
    String guestGubun = new String();
	String guestJoin = new String();				//��������	����
    String guestPrice = new String();
    String guestNameStr = new String();
    String guestJuminNoStr = new String();
    String guestGubunStr = new String();
    String guestJoinStr = new String();			//��������	�迭
    
    for (int i = 0;i < roomCnt; i++)
    {
        upjangSid = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_upjangSid"), 0);
        roomTypeSid = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_roomTypeSid"), 0);
        guestCnt = Util.parseInt(request.getParameter("room_" + String.valueOf(i) + "_guestCnt"), 0);
        
        sb.append("upjangSid_" + String.valueOf(i) + " : " + String.valueOf(upjangSid) + "\n");
        sb.append("roomTypeSid_" + String.valueOf(i) + " : " + String.valueOf(roomTypeSid) + "\n");
        sb.append("guestCnt_" + String.valueOf(i) + " : " + String.valueOf(guestCnt) + "\n");
        
        for(int j = 0 ; j< guestCnt ; j++)	//1���� �� �� ��
        {
             
            guestName = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_name")); //������ �̸�
            guestJuminNo = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_juminNo"));//������ �ֹι�ȣ
            guestGubun = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_gubun"));//������ ���� (����,����л�,���л�....)
            guestPrice = ParamUtil.getReqParameter(request.getParameter("room_" + String.valueOf(i) + "_guest_" + String.valueOf(j) + "_price"));//������ ���
            guestPrice = guestPrice.replaceAll(",","");

            sb.append("guestName_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestName + "\n");
            sb.append("guestJuminNo_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestJuminNo + "\n");
            sb.append("guestGubun_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestGubun + "\n");
            sb.append("guestPrice_" + String.valueOf(i) + "_" + String.valueOf(j) + " : " + guestPrice + "\n");
            
			//�����ڵ� ����
			if(j==0){
				guestJoin = "01";		//����
			}else{
				guestJoin = "02";		//����
			};


			//��Ʈ�� �����
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
        
        
            /*������ ���� insert start*/
          
                Reservation_bean bean = new Reservation_bean();
                ReservationInfo dao = new ReservationInfo();
                
                bean.setRname(name);//����
                bean.setRmob(tel);//�̵���ȭ��ȣ
                bean.setRmail(email);//�̸���
                bean.setRpass(pwd);//��й�ȣ
                bean.setRstdt(reservDate); //�����
                bean.setRedt(arriveDate); //������
                bean.setRstat("1");//�������(1:����)
                
                
                //if  (goods == "1111201" ){//1��
                //    goods = "27";
                //}else{//2��
                //    goods = "28";
                //}
                
                if  (goods == "1111200" || goods.equals("1111200")){//1��
                    goods = "27";
                }else{//2��
                    goods = "28";
                } 
            
            
                bean.setRscod(goods);//���ڼ�
                //System.out.println("-------------------guestJuminNoStr------------------------------------------"+guestJuminNoStr);
                //System.out.println("-------------------guestNameStr------------------------------------------"+guestNameStr);
                //System.out.println("-------------------guestGubunStr------------------------------------------"+guestGubunStr);
                
                //guestJuminNoStr = "8112172222222";
                
                bean.setRegi_no(guestJuminNoStr);//�ֹι�ȣ
                bean.setCust_nm(guestNameStr);//����
                bean.setAge_cd(guestGubunStr);//�����ڵ�	 : �����ڵ� ����;;;;
				bean.setJoin_cd(guestJoinStr);//�����ڵ�	 : �����ڵ� ����;;;;

                
                bean.setCust_ip(request.getRemoteAddr());//���Ӿ�����
                bean.setUpjang_sid(upjangSid);//����Ÿ�� 'HHSTT'
                bean.setRoom_type_sid(roomTypeSid);//����Ÿ��SID
                DbMesage = dao.RevInsert(bean);
                
            /*������ ���� insert end*/
                    
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
     
     //result = new String(result);//insert ����� , OK = "Y" Error = "N"
     
     String comment = new String();//result == "N" �� ����� ����
     out.println("&result=" + result + "&comment="+ message + "&op=" + URLEncoder.encode(op));
     
   // }else{
    //}
    
%>