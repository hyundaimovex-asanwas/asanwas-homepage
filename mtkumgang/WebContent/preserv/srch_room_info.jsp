<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ page import="kr.co.imjk.reservation.dao.RoomInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Room_bean"%>

<%
	String upjang_sid = request.getParameter("upjang_sid");			//����ID
	String goods_sid = request.getParameter("goods_sid");					//������ǰ �ڵ�
	String saup_sid = request.getParameter("saup_sid");					//������ �ڵ�
	String start_ymd = request.getParameter("start_ymd");				//�������

	//������ȸ�� ���� param bean ����
	Room_bean param = new Room_bean();
	Room_bean[] result = null;

	//������ȸ�� ���� �Լ�����
	RoomInfo info = new RoomInfo();

	//�Ķ���� ����
	param.setStart_ymd(start_ymd);		//���õ�����
	param.setSaup_sid(saup_sid);			//������
	param.setGoods_sid(goods_sid);			//����ǰ��
	param.setUpjang_sid(upjang_sid);		//����ID

	try {
		//���ν��� ȣ��
		result = info.getRoomList(param);
		StringBuffer xml = new StringBuffer("");

		xml.append("<?xml version='1.0' encoding='EUC-KR'?>");
		xml.append("<RESULT>");
			
		if(result != null) {
			for(int i=0 ; i<result.length ; i++) {
				xml.append("<LIST>");
				xml.append("	 <ROOM_SID>");
				xml.append((result[i].getRoom_type_sid()).trim());
				xml.append("	 </ROOM_SID>");
				xml.append("	 <ROOM_NM>");
				xml.append((result[i].getRoom_type_nm()).trim());
				xml.append("	 </ROOM_NM>");
				xml.append("	 <CNT>");
				xml.append(result[i].getCnt());
				xml.append("	 </CNT>");
				xml.append("	 <RSV_YN>");
				xml.append(result[i].getRsv_yn());
				xml.append("	 </RSV_YN>");
				xml.append("	 <PRICE>");
				xml.append(result[i].getDouble_1());
				xml.append("	 </PRICE>");
				xml.append("	 <MAX_P>");
				xml.append(result[i].getMax_p());
				xml.append("	 </MAX_P>");
				xml.append("</LIST>");
			}
		}
		xml.append("</RESULT>");

		response.setContentType("text/xml; charset=euc-kr");
		response.getWriter().write(xml.toString());
		
		if(result != null) {
			for(int i=0;i<result.length;i++) {

			}
		}


	} catch(Exception e) {
		e.printStackTrace();
	}
%>



