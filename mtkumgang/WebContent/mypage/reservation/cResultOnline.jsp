<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>

<%
	//8�ڸ� ��¥ �� �ҷ�����
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String reg_date = m_today.format(date.getTime());	

    String c_pay_gubn     = ParamUtil.getReqParameter(request.getParameter("c_pay_gubn"));       //����: ��������
    String c_van_cd       = ParamUtil.getReqParameter(request.getParameter("c_van_cd"));			//����: VAN ����
    String c_acct_join_no = ParamUtil.getReqParameter(request.getParameter("c_acct_join_no"));   //������ ID
    String c_terminal_id  = ParamUtil.getReqParameter(request.getParameter("c_terminal_id"));    //�ܸ����ȣ ���̵�
    String c_return_url   = ParamUtil.getReqParameter(request.getParameter("c_return_url"));		//return URL
    String s_agree_time   = ParamUtil.getReqParameter(request.getParameter("s_agree_time")); 	//�����Ͻ�
    String s_bank_cd      = ParamUtil.getReqParameter(request.getParameter("s_bank_cd"));		//����: �����ڵ�
   
    String rscod      = ParamUtil.getReqParameter(request.getParameter("r_user_key"));		    //��ǰ�� (��ǰ�ڵ�)
    String rsv_sid       = ParamUtil.getReqParameter(request.getParameter("rsv_sid"));		   //���� SID (�߰��ʵ�)

    // ============================================================================== //
    // =   ���� ���                                                                                                                    = //
    // = -------------------------------------------------------------------------- = //
    String req_tx         = ParamUtil.getReqParameter(request.getParameter("req_tx"));                      // ��û ����(����/���)
    String use_pay_method = ParamUtil.getReqParameter(request.getParameter("use_pay_method"));              // ��� ���� ����
    String bSucc          = ParamUtil.getReqParameter(request.getParameter("bSucc"));                       // ��ü DB ����ó�� �Ϸ� ����

    String res_cd         = ParamUtil.getReqParameter(request.getParameter("s_resp_code"));                 // ��� �ڵ�
    String res_msg        = ParamUtil.getReqParameter(request.getParameter("res_msg"));                     // ��� �޽���

    String ordr_idxx         = ParamUtil.getReqParameter(request.getParameter("c_pay_manage_no"));                // �ֹ���ȣ
    
    String tno            = ParamUtil.getReqParameter(request.getParameter("s_van_idx_no"));                // KCP �ŷ���ȣ
    int good_mny          = ParamUtil.getIntParameter(request.getParameter("c_pay_amt"));                   // ���� �ݾ�
    String good_name      = ParamUtil.getReqParameter(request.getParameter("s_user_key"));                  // ��ǰ��
    String buyr_name      = ParamUtil.getReqParameter(request.getParameter("r_order_nm"));                  // �����ڸ�
    String buyr_tel1      = ParamUtil.getReqParameter(request.getParameter("s_order_tel_no"));              // ������ ��ȭ��ȣ
    String buyr_tel2      = ParamUtil.getReqParameter(request.getParameter("buyr_tel2"));                   // ������ �޴�����ȣ
    String buyr_mail      = ParamUtil.getReqParameter(request.getParameter("s_order_e_mail"));              // ������ E-Mail

    // �ſ�ī��
    String card_cd        = ParamUtil.getReqParameter(request.getParameter("s_card_cd"));                   // ī�� �ڵ�
    String card_name      = ParamUtil.getReqParameter(request.getParameter("s_card_name"));                 // ī���
    String app_time       = ParamUtil.getReqParameter(request.getParameter("s_app_time"));                  // ���νð� (����)
    String app_no         = ParamUtil.getReqParameter(request.getParameter("s_app_no"));                    // ���ι�ȣ
    String quota          = ParamUtil.getReqParameter(request.getParameter("s_quota"));                     // �Һΰ���

     // ������ü
    String bank_name      = ParamUtil.getReqParameter(request.getParameter("s_bank_nm"));                   // �����

    // �������
    String s_order_nm     = ParamUtil.getReqParameter(request.getParameter("s_order_nm"));                  //  �Աݰ��� ������
    String s_bank_acct    = ParamUtil.getReqParameter(request.getParameter("s_bank_acct"));                 //  �Աݰ��� ��ȣ

    
    String req_tx_name ="";
    if(req_tx.equals("pay")){
        req_tx_name = "����";
    }else if(req_tx.equals("mod")){
        req_tx_name = "����/���";
    }else{
    
    }    

%>

<%
  //�ŷ� ���� : ����
 if(req_tx.equals("pay")){   

     //��ü DB ó�� ����
     if (!bSucc.equals("false")){
            //���� ����
            if(res_cd.equals("0000")){  
                
                //DBó�� (SALES.TRV240, SALES.TRV020, SALES.TRV200)
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
                bean.setCust_ip(request.getRemoteAddr());//���Ӿ�����
                bean.setMulti_yn("N");  //���߰���

				bean.setRegdate(reg_date); //��û��			���⼭ ��û���ڸ� �����ϰ� �����µ�.. ���ð��� Ʋ�� ��.

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
                
            // ���� ����
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

     //��ü DB ó�� ����
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