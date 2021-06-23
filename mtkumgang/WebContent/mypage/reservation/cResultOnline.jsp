<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>

<%
	//8자리 날짜 값 불러오기
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String reg_date = m_today.format(date.getTime());	

    String c_pay_gubn     = ParamUtil.getReqParameter(request.getParameter("c_pay_gubn"));       //공통: 결제수단
    String c_van_cd       = ParamUtil.getReqParameter(request.getParameter("c_van_cd"));			//공통: VAN 구분
    String c_acct_join_no = ParamUtil.getReqParameter(request.getParameter("c_acct_join_no"));   //가맹점 ID
    String c_terminal_id  = ParamUtil.getReqParameter(request.getParameter("c_terminal_id"));    //단말기번호 아이디
    String c_return_url   = ParamUtil.getReqParameter(request.getParameter("c_return_url"));		//return URL
    String s_agree_time   = ParamUtil.getReqParameter(request.getParameter("s_agree_time")); 	//지불일시
    String s_bank_cd      = ParamUtil.getReqParameter(request.getParameter("s_bank_cd"));		//응답: 은행코드
   
    String rscod      = ParamUtil.getReqParameter(request.getParameter("r_user_key"));		    //상품명 (상품코드)
    String rsv_sid       = ParamUtil.getReqParameter(request.getParameter("rsv_sid"));		   //예약 SID (추가필드)

    // ============================================================================== //
    // =   지불 결과                                                                                                                    = //
    // = -------------------------------------------------------------------------- = //
    String req_tx         = ParamUtil.getReqParameter(request.getParameter("req_tx"));                      // 요청 구분(승인/취소)
    String use_pay_method = ParamUtil.getReqParameter(request.getParameter("use_pay_method"));              // 사용 결제 수단
    String bSucc          = ParamUtil.getReqParameter(request.getParameter("bSucc"));                       // 업체 DB 정상처리 완료 여부

    String res_cd         = ParamUtil.getReqParameter(request.getParameter("s_resp_code"));                 // 결과 코드
    String res_msg        = ParamUtil.getReqParameter(request.getParameter("res_msg"));                     // 결과 메시지

    String ordr_idxx         = ParamUtil.getReqParameter(request.getParameter("c_pay_manage_no"));                // 주문번호
    
    String tno            = ParamUtil.getReqParameter(request.getParameter("s_van_idx_no"));                // KCP 거래번호
    int good_mny          = ParamUtil.getIntParameter(request.getParameter("c_pay_amt"));                   // 결제 금액
    String good_name      = ParamUtil.getReqParameter(request.getParameter("s_user_key"));                  // 상품명
    String buyr_name      = ParamUtil.getReqParameter(request.getParameter("r_order_nm"));                  // 구매자명
    String buyr_tel1      = ParamUtil.getReqParameter(request.getParameter("s_order_tel_no"));              // 구매자 전화번호
    String buyr_tel2      = ParamUtil.getReqParameter(request.getParameter("buyr_tel2"));                   // 구매자 휴대폰번호
    String buyr_mail      = ParamUtil.getReqParameter(request.getParameter("s_order_e_mail"));              // 구매자 E-Mail

    // 신용카드
    String card_cd        = ParamUtil.getReqParameter(request.getParameter("s_card_cd"));                   // 카드 코드
    String card_name      = ParamUtil.getReqParameter(request.getParameter("s_card_name"));                 // 카드명
    String app_time       = ParamUtil.getReqParameter(request.getParameter("s_app_time"));                  // 승인시간 (공통)
    String app_no         = ParamUtil.getReqParameter(request.getParameter("s_app_no"));                    // 승인번호
    String quota          = ParamUtil.getReqParameter(request.getParameter("s_quota"));                     // 할부개월

     // 계좌이체
    String bank_name      = ParamUtil.getReqParameter(request.getParameter("s_bank_nm"));                   // 은행명

    // 가상계좌
    String s_order_nm     = ParamUtil.getReqParameter(request.getParameter("s_order_nm"));                  //  입금계좌 예금주
    String s_bank_acct    = ParamUtil.getReqParameter(request.getParameter("s_bank_acct"));                 //  입금계좌 번호

    
    String req_tx_name ="";
    if(req_tx.equals("pay")){
        req_tx_name = "지불";
    }else if(req_tx.equals("mod")){
        req_tx_name = "매입/취소";
    }else{
    
    }    

%>

<%
  //거래 구분 : 승인
 if(req_tx.equals("pay")){   

     //업체 DB 처리 정상
     if (!bSucc.equals("false")){
            //정상 승인
            if(res_cd.equals("0000")){  
                
                //DB처리 (SALES.TRV240, SALES.TRV020, SALES.TRV200)
                //DAO
                ReservationInfo dao = new ReservationInfo();
                //DTO
                Reservation_bean bean = new Reservation_bean();    

                //bean.setOl_care_sid(rscod);
                bean.setPay_manage_no(ordr_idxx);
                bean.setPay_amt(good_mny);
                bean.setOrder_nm(buyr_name);
                bean.setOrder_e_mail(buyr_mail);
                bean.setOrder_tel_no(buyr_tel1);
                //bean.setBuyr_tel2();
                bean.setResp_code(res_cd);
                bean.setRes_msg(res_msg);
                bean.setVan_idx_no(tno);
                bean.setCard_cd(card_cd);
                bean.setCard_name(card_name);
                bean.setApp_time(app_time);
                bean.setApp_no(app_no);
                bean.setQuota(quota);
                //bean.setSuccess();
                bean.setUser_key(rscod); 
                //bean.setRsv_sid(rsv_sid); 
                bean.setRsv_sid_multi(rsv_sid); 
                bean.setCust_ip(request.getRemoteAddr());//접속아이피
                bean.setMulti_yn("N");  //다중결제

				bean.setRegdate(reg_date); //신청일			여기서 신청일자를 세팅하고 던지는데.. 세팅값이 틀린 듯.

                int result = 0;
                result = dao.getPayUpdate(bean);
                if (result > 0){
                    
                    out.println("<script language='javascript'>");
                    out.println("  alert('"+res_msg+"');");
                    out.println("  parent.location.reload();");
                    out.println("</script>");
                    out.flush();
                    out.close();
                    return;
                    
                }else{
                
                    out.println("<script language='javascript'>");
                    out.println("  alert('"+res_msg+"');");
                    out.println("  parent.location.reload();");
                    out.println("</script>");
                    out.flush();
                    out.close();
                    return;
                    
                }
                
            // 승인 실패
            }else{
            //out.println(res_cd+"<br>"+res_msg);
                    out.println("<script language='javascript'>");
                    out.println("  alert('"+res_msg+"');");
                    out.println("  parent.location.reload();");
                    out.println("</script>");
                    out.flush();
                    out.close();
                    return;            

            }

     //업체 DB 처리 실패
     }else{
                    out.println("<script language='javascript'>");
                    out.println("  alert('"+res_msg+"');");
                    out.println("  parent.location.reload();");
                    out.println("</script>");
                    out.flush();
                    out.close();
                    return;  
     }
       

}

%>