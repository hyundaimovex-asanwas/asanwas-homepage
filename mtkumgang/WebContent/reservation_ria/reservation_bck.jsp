<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.RiaReservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.RiaReservationInfo"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page buffer="0"%>
<%

                
    try
    {
        StringBuffer sb = new StringBuffer("");
        String serDate = ParamUtil.getReqParameter(request.getParameter("serDate"));
        String today = new String();
        String stday = new String();
        Calendar cal = Calendar.getInstance();

        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
        
        month = month.length()>1 ? month : "0" + month;
        day = day.length() > 1 ? day : "0" + day;
        
        today = year + month + day;

        if(!serDate.equals("") && serDate.length() >= 6)
        {
            cal.set(Integer.parseInt(serDate.substring(0,4)),Integer.parseInt(serDate.substring(4,6)) - 1,1);
        }
        
        year = String.valueOf(cal.get(Calendar.YEAR));      
        month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String tempMonth = month;
        
        String fday = String.valueOf(cal.getActualMinimum(Calendar.DAY_OF_MONTH));
        String lday = String.valueOf(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        
        month = month.length()>1 ? month : "0" + month;
        fday = fday.length() > 1 ? fday : "0" + fday;
        lday = lday.length() > 1 ? lday : "0" + lday;
        
        fday = year + month + fday;
        lday = year + month + lday;
        
        RiaReservationInfo dao = new RiaReservationInfo();
        RiaReservation_bean bean = new RiaReservation_bean();
        
        cal.set(Integer.parseInt(today.substring(0,4)),Integer.parseInt(today.substring(4,6)) - 1,Integer.parseInt(today.substring(6)) + 15);
        year = String.valueOf(cal.get(Calendar.YEAR));       
        month = String.valueOf(cal.get(Calendar.MONTH) + 1); 
        day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        month = month.length()>1 ? month : "0" + month;
        day = day.length() > 1 ? day : "0" + day;
        
        stday = year + month + day;
        
        bean.setStandard_date(stday);
        bean.setSer_st_date(fday);
        bean.setSer_ed_date(lday);
        
        RiaReservation_bean [] list = dao.getList(bean);
        
        String xml = new String();

        sb.append("<?xml version=\"1.0\" encoding=\"euc-kr\"?>");
        sb.append("<Reservation>");
        //sb.append("<today>" + today + "</today>");
        //sb.append("<fday>" + fday + "</fday>");
        //sb.append("<lday>" + lday + "</lday>");
        //sb.append("<stday>" + stday + "</stday>");
        //sb.append("<month>"+ String.valueOf(Integer.parseInt(serDate.substring(4,6))-1) +"</month>");
        //sb.append("<month1>" + tempMonth + "</month1>");
        int x = 0;
        
        String tempDate = new String();
        String nextDate = new String();
        
        for(int i = 0;i<list.length;i++)
        {
            tempDate = list[i].getCurr_date();
            cal.set(Integer.parseInt(tempDate.substring(0,4)),Integer.parseInt(tempDate.substring(4,6)) - 1, Integer.parseInt(tempDate.substring(6)));
            cal.add(Calendar.DAY_OF_MONTH,1);
            year = String.valueOf(cal.get(Calendar.YEAR));             
            month = String.valueOf(cal.get(Calendar.MONTH) + 1);       
            day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));      

            month = month.length()>1 ? month : "0" + month;
            day = day.length() > 1 ? day : "0" + day;
            
            nextDate = year + month + day;
            if(i != list.length - 1) //���������� �ƴҶ�
            {
                if(i == 0) //ù���϶�
                {
                    sb.append("  <day_data>");
                    sb.append("    <curr_date>" + tempDate + "</curr_date>");
                    sb.append("    <next_date>" + nextDate + "</next_date>");
                    sb.append("    <rsv_yn>" + list[i].getRsv_yn() + "</rsv_yn> ");
                    sb.append("    <upjang_list>");
                    sb.append("      <upjang>");
                    sb.append("        <upjang_id>" + list[i].getUpjang_sid() + "</upjang_id>");
                    sb.append("        <upjang_cd>" + list[i].getUpjang_cd() + "</upjang_cd>");
                    sb.append("        <upjang_nm><![CDATA[" + list[i].getUpjang_nm() + "]]></upjang_nm>");
                    sb.append("        <room_type_list>");
                    sb.append("          <room_type>");
                    sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                    sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd> ");
                    sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                    sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                    sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                    sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                    sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                    sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                    sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                    sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                    sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                    sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                    sb.append("          </room_type>"); // ���� ��� �Ϸ�
                }
                else
                {
                    if(!tempDate.equals(list[i-1].getCurr_date())) //������� ��¥�� �����ʴٸ�==>��¥�� �ٲ�,��¥ element�� ������
                    {
                        sb.append("  <day_data>");
                        sb.append("    <curr_date>" + tempDate + "</curr_date>");
                        sb.append("    <next_date>" + nextDate + "</next_date>");
                        sb.append("    <rsv_yn>" + list[i].getRsv_yn() + "</rsv_yn> ");
                        sb.append("    <upjang_list>");
                        sb.append("      <upjang>");
                        sb.append("        <upjang_id>" + list[i].getUpjang_sid() + "</upjang_id>");
                        sb.append("        <upjang_cd>" + list[i].getUpjang_cd() + "</upjang_cd>");
                        sb.append("        <upjang_nm><![CDATA[" + list[i].getUpjang_nm() + "]]></upjang_nm>");
                        sb.append("        <room_type_list>");
                        sb.append("          <room_type>");
                        sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                        sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd> ");
                        sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // ���� ��� �Ϸ�
                    }
                    else if(!tempDate.equals(list[i+1].getCurr_date())) //������� ��¥�� ���� �ʴٸ� ==>��������� ��¥�� �ٲ�,element�� �ݾ���
                    {
                        sb.append("          <room_type>");
                        sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                        sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd>");
                        sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // ���� ��� �Ϸ�
                        sb.append("        </room_type_list>");
                        sb.append("      </upjang>");
                        sb.append("    </upjang_list>");
                        sb.append("  </day_data>");//element�� �� ����
                    }
                    else // �߰� ���̶��
                    {
                        if(list[i].getUpjang_sid() != list[i - 1].getUpjang_sid()) //������� ������ ���� �ʴٸ�, ���� �±׸� ������
                        {
                            sb.append("      <upjang>");
                            sb.append("        <upjang_id>" + list[i].getUpjang_sid() + "</upjang_id>");
                            sb.append("        <upjang_cd>" + list[i].getUpjang_cd() + "</upjang_cd>");
                            sb.append("        <upjang_nm><![CDATA[" + list[i].getUpjang_nm() + "]]></upjang_nm>");
                            sb.append("        <room_type_list>");
                        }
            
                        sb.append("          <room_type>");
                        sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                        sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd> ");
                        sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // ���� ��� �Ϸ�
                        
                        if(list[i].getUpjang_sid() != list[i + 1].getUpjang_sid()) //������� ������ ���� �ʴٸ�, ���� �±׸� �ݾ���
                        {
                            sb.append("        </room_type_list>");
                            sb.append("      </upjang>");
                        }
                    }
                }
            }
            else//������ ���϶�
            {
                sb.append("        </room_type_list>");
                sb.append("      </upjang>");
                sb.append("    </upjang_list>");
                sb.append("  </day_data>");//element�� �� ����
            }
        }
        sb.append("</Reservation>");
        
        xml = sb.toString();
        out.println(xml);
    }
    catch(Exception e)
    {
        e.printStackTrace(new PrintWriter(out));
    }
%>