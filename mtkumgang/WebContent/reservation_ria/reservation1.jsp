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
        
        String[] HotelInfo = new String[7];
        HotelInfo[0] = "";
        HotelInfo[1] = "만물상 입구에 자리잡은 금강산호텔에서는 천혜의 자연경관과 함께 북측봉사원들의 친절한 서비스를 경험할 수 있습니다.";
        HotelInfo[2] = "금강산 호텔을 마주하며 푸른 숲속에 위치한 자연의 순수함과 편안함을 담은 쾌적한 호텔입니다.";
        HotelInfo[3] = "금강산절경과 고성항의 푸른바다를 한눈에 조망할 수 있고 다양한 객실을 구비하고 있는 금강산 명품 호텔입니다.";
        HotelInfo[4] = "";
        HotelInfo[5] = "외금강 산자락을 병풍처럼 두루고 있는 외금강호텔은 북측 최고 명소인 김정숙휴양소를 리모델링한 고품격 호텔입니다.";
        HotelInfo[6] = "최고급 해상호텔인 호텔해금강은 금강산관광의 품격과 여유를 상징하는 대표적인 호텔입니다. ";
        
        Hashtable hash = new Hashtable();        
        hash.put("GHDSD","남다른 여유로움과 격조 높음을 추구한다면 디럭스스위트가 손색이 없을 것입니다. 넓은 공간에서 느껴지는 쾌적함이 금강산 관광의 즐거움을 더해줄 것입니다.");
        hash.put("GHDXD","남다른 여유로움과 격조 높음을 추구한다면 디럭스스위트가 손색이 없을 것입니다. 넓은 공간에서 느껴지는 쾌적함이 금강산 관광의 즐거움을 더해줄 것입니다.");
        hash.put("GHDXT","남다른 여유로움과 격조 높음을 추구한다면 디럭스스위트가 손색이 없을 것입니다. 넓은 공간에서 느껴지는 쾌적함이 금강산 관광의 즐거움을 더해줄 것입니다.");
        hash.put("GHRSD","남과 북의 고유한 문화가 조화를 이룬 금강산 최고의 고품격 공간이며, 최고의 객실과 서비스를 제공한다. 탁 트인 멋진 추억을 남기기에 충분할 것입니다.");
        hash.put("GHSTO","북측 특유의 정취와 분위기를 느낄 수 있는 인테리어로 금강산 관광만의 독특함을 더해주는 안락한 공간입니다.");
        hash.put("GHSTT","북측 특유의 정취와 분위기를 느낄 수 있는 인테리어로 금강산 관광만의 독특함을 더해주는 안락한 공간입니다.");
        hash.put("GHSWO","보다 넉넉함을 추구하는 고객을 위한 공간으로 심플한 인테리어로 여유로움을 강조한 편안한 공간입니다.");
        hash.put("GHSWT","보다 넉넉함을 추구하는 고객을 위한 공간으로 심플한 인테리어로 여유로움을 강조한 편안한 공간입니다.");
        hash.put("GBSTO","북측 특유의 정취와 분위기를 느낄 수 있는 인테리어로 금강산 관광만의 독특함을 더해주는 안락한 공간입니다.");
        hash.put("GBSWO","보다 넉넉함을 추구하는 고객을 위한 공간으로 심플한 인테리어로 여유로움을 강조한 편안한 공간입니다.");
        hash.put("FHFSD","복층구조의 넓고 아늑한 분위기로 온가족이 여유롭고 편히 쉴 수 있는 공간입니다.");
        hash.put("FHRSD","특별한 고객을 위한 고품격의 공간으로 최고의 전망과 고급스러운 인테리어로 최고의 서비스를 제공합니다.");
        hash.put("FHSTT","심플한 인테리어와 편의시설로 아늑하고 편안한 휴식공간을 제공합니다.");
        hash.put("MHDSD","넓은 공간과 특별한 여유로움을 원하신다면 디럭스스위트를 추천합니다. 디럭스의 넉넉함과 안락함이 가슴에 남는 금강산관광으로 만들어 줄것 입니다.");
        hash.put("MHJRO","아담하고 편안한 분위기의 객실로서 실용성을 갖춘 객실입니다.");
        hash.put("MHSTO","아담하고 편안한 분위기의 객실로서 실용성을 갖춘 객실입니다.");
        hash.put("MHSTT","아담하고 편안한 분위기의 객실로서 실용성을 갖춘 객실입니다.");
        hash.put("MHSWD","내집같이 아늑하고 편안함과 고급스러움을 함께하는 공간입니다. 보다 안락한 분위기를 선호하신다면 후회없는 선택이 될것입니다. ");
        hash.put("MHSWT","내집같이 아늑하고 편안함과 고급스러움을 함께하는 공간입니다. 보다 안락한 분위기를 선호하신다면 후회없는 선택이 될것입니다. ");
        hash.put("HHBZO","리모델링을 통해 더욱 새로워진 객실은 여정의 피로를 풀어주기에 더없이 안락한 장소가 되어줄 것입니다.");
        hash.put("HHDXD","보다 여유로움과 안락함을 추구하신다면 고급실을 이용하는 것도 좋으시며 해상호텔에서의 하룻밤은 더없이 소중한 추억으로 남을 것입니다.");
        hash.put("HHFSD","침실 2개와 거실이 함께 있어 한 가족이 이용하기에 불편함이 없도록 여유롭게 만들어진 넉넉하고 포근한 공간입니다.");
        hash.put("HHRSD","특별한 고객을 모시기에 소홀함이 없도록 정성껏 꾸며진 공간입니다. 별도의 침실과 거실로 분리되어 있으며, 넉넉한 실내공간을 확보하였습니다.");
        hash.put("HHSTD","리모델링을 통해 더욱 새로워진 객실은 여정의 피로를 풀어주기에 더없이 안락한 장소가 되어줄 것입니다.");
        hash.put("HHSTT","리모델링을 통해 더욱 새로워진 객실은 여정의 피로를 풀어주기에 더없이 안락한 장소가 되어줄 것입니다.");
        
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
            if(i != list.length - 1) //마지막행이 아닐때
            {
                if(i == 0) //첫행일때
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
                    sb.append("        <upjang_s_img>/img4RIA20060926/ria_h"+list[i].getUpjang_sid()+"S.jpg</upjang_s_img>");
                    sb.append("        <upjang_m_img>/img4RIA20060926/ria_h"+list[i].getUpjang_sid()+"M.jpg</upjang_m_img>");
                    sb.append("        <upjang_info><![CDATA["+HotelInfo[list[i].getUpjang_sid()]+"]]></upjang_info>");
                    sb.append("        <room_type_list>");
                    sb.append("          <room_type>");
                    sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                    sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd> ");
                    sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                    sb.append("            <room_type_s_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"S.jpg</room_type_s_img>");
                    sb.append("            <room_type_m_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"M.jpg</room_type_m_img>");
                    sb.append("            <room_type_info><![CDATA[" + (String)hash.get(list[i].getRoom_type_cd()) + "]]></room_type_info> ");
                    sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                    sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                    sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                    sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                    sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                    sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                    sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                    sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                    sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                    sb.append("          </room_type>"); // 한행 출력 완료
                }
                else
                {
                    if(!tempDate.equals(list[i-1].getCurr_date())) //이전행과 날짜가 같지않다면==>날짜가 바뀜,날짜 element를 열어줌
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
                        sb.append("            <room_type_s_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"S.jpg</room_type_s_img>");
                        sb.append("            <room_type_m_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"M.jpg</room_type_m_img>");
                        sb.append("            <room_type_info><![CDATA[" + (String)hash.get(list[i].getRoom_type_cd()) + "]]></room_type_info> ");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // 한행 출력 완료
                    }
                    else if(!tempDate.equals(list[i+1].getCurr_date())) //다음행과 날짜가 같지 않다면 ==>다음행부터 날짜가 바뀜,element를 닫아줌
                    {
                        sb.append("          <room_type>");
                        sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                        sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd>");
                        sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                        sb.append("            <room_type_s_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"S.jpg</room_type_s_img>");
                        sb.append("            <room_type_m_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"M.jpg</room_type_m_img>");
                        sb.append("            <room_type_info><![CDATA[" + (String)hash.get(list[i].getRoom_type_cd()) + "]]></room_type_info> ");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // 한행 출력 완료
                        sb.append("        </room_type_list>");
                        sb.append("      </upjang>");
                        sb.append("    </upjang_list>");
                        sb.append("  </day_data>");//element를 다 닫음
                    }
                    else // 중간 행이라면
                    {
                        if(list[i].getUpjang_sid() != list[i - 1].getUpjang_sid()) //이전행과 업장이 같지 않다면, 업장 태그를 열어줌
                        {
                            sb.append("      <upjang>");
                            sb.append("        <upjang_id>" + list[i].getUpjang_sid() + "</upjang_id>");
                            sb.append("        <upjang_cd>" + list[i].getUpjang_cd() + "</upjang_cd>");
                            sb.append("        <upjang_nm><![CDATA[" + list[i].getUpjang_nm() + "]]></upjang_nm>");
                            sb.append("        <upjang_s_img>/img4RIA20060926/ria_h"+list[i].getUpjang_sid()+"S.jpg</upjang_s_img>");
                            sb.append("        <upjang_m_img>/img4RIA20060926/ria_h"+list[i].getUpjang_sid()+"M.jpg</upjang_m_img>");                            
                            sb.append("        <upjang_info><![CDATA["+HotelInfo[list[i].getUpjang_sid()]+"]]></upjang_info>");
                            sb.append("        <room_type_list>");
                        }
            
                        sb.append("          <room_type>");
                        sb.append("            <room_type_sid>" + list[i].getRoom_type_sid() + "</room_type_sid>");
                        sb.append("            <room_type_cd>" + list[i].getRoom_type_cd() + "</room_type_cd> ");
                        sb.append("            <room_type_nm><![CDATA[" + list[i].getRoom_type_nm() + "]]></room_type_nm>");
                        sb.append("            <room_type_s_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"S.jpg</room_type_s_img>");
                        sb.append("            <room_type_m_img>/img4RIA20060926/ria_room"+list[i].getRoom_type_sid()+"M.jpg</room_type_m_img>");
                        sb.append("            <room_type_info><![CDATA[" + (String)hash.get(list[i].getRoom_type_cd()) + "]]></room_type_info> ");
                        sb.append("            <total_cnt>" + list[i].getTotal() + "</total_cnt>");
                        sb.append("            <one_day>" + list[i].getOne_day() + "</one_day>");
                        sb.append("            <two_day>" + list[i].getTwo_day() + "</two_day>");
                        sb.append("            <price1>" + list[i].getPrice1() + "</price1>");
                        sb.append("            <price2>" + list[i].getPrice2() + "</price2>");
                        sb.append("            <price3>" + list[i].getPrice3() + "</price3>");
                        sb.append("            <price4>" + list[i].getPrice4() + "</price4>");
                        sb.append("            <price5>" + list[i].getPrice5() + "</price5>");
                        sb.append("            <price6>" + list[i].getPrice6() + "</price6>");
                        sb.append("          </room_type>"); // 한행 출력 완료
                        
                        if(list[i].getUpjang_sid() != list[i + 1].getUpjang_sid()) //다음행과 업장이 같지 않다면, 업장 태그를 닫아줌
                        {
                            sb.append("        </room_type_list>");
                            sb.append("      </upjang>");
                        }
                    }
                }
            }
            else//마지막 행일때
            {
                sb.append("        </room_type_list>");
                sb.append("      </upjang>");
                sb.append("    </upjang_list>");
                sb.append("  </day_data>");//element를 다 닫음
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