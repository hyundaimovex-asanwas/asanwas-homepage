<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
/*   EZGEN 파일에서 받는 parameter값 */
if ( request.getParameter("occ_cd").equals("") || request.getParameter("occ_cd").equals(null) ) {}
else 
{
    String occ_cd  = request.getParameter("occ_cd");       // 조회구분
    String pis_ymd = request.getParameter("pis_ymd");      // 일자
    String pis_y = pis_ymd.substring(0,4);
    String pis_m = pis_ymd.substring(5,7);
    String pis_d = pis_ymd.substring(8,10);
    String pis_ymd_val = pis_y + pis_m + pis_d;
    String pid_d_val = "AT" + Integer.parseInt(pis_d)  + "_CD";
    
    String gbn2_tag = "";
    int eno_no_cnt1  = 0;
    int s_at5_cnt1   = 0;
    int sago_cnt1    = 0;
    int eno_no_e1    = 0;
    int eno_no_t1    = 0;
    int eno_no_f1    = 0;
    int eno_no_q1    = 0;
    int eno_no_ruv1  = 0;
    int eno_no_h1    = 0;
    int eno_no_z1    = 0;
    int eno_no_i1    = 0;
    int eno_no_ab1   = 0;
    int eno_no_l1    = 0;
    int eno_no_c1    = 0;

    int eno_no_cnt2  = 0;
    int s_at5_cnt2   = 0;
    int sago_cnt2    = 0;
    int eno_no_e2    = 0;
    int eno_no_t2    = 0;
    int eno_no_f2    = 0;
    int eno_no_q2    = 0;
    int eno_no_ruv2  = 0;
    int eno_no_h2    = 0;
    int eno_no_z2    = 0;
    int eno_no_i2    = 0;
    int eno_no_ab2   = 0;
    int eno_no_l2    = 0;
    int eno_no_c2    = 0;

    String sql = XmlSqlUtils.getSQL("gun", "GUNA090_SHR");
//    System.out.println(sql);
    Object[] sqlParam = new Object[] {
        occ_cd, pid_d_val, pid_d_val, occ_cd, pid_d_val, pid_d_val, occ_cd, pid_d_val, pid_d_val, occ_cd		
    };
        
    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    Object[] bind = new Object[] {
        pis_y, pis_m, pis_y, pis_m, pis_y, pis_m, pis_y, pis_m, pis_ymd_val, pis_ymd_val
    };
    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("총원");
    hnwExtQuery.AddField("사고");
    hnwExtQuery.AddField("출근");
    hnwExtQuery.AddField("출장");
    hnwExtQuery.AddField("대체휴가");
    hnwExtQuery.AddField("교육");
    hnwExtQuery.AddField("기념");
    hnwExtQuery.AddField("반차");
    hnwExtQuery.AddField("연차");
    hnwExtQuery.AddField("refresh");
    hnwExtQuery.AddField("특휴가");
    hnwExtQuery.AddField("결근");
    hnwExtQuery.AddField("기타");
    hnwExtQuery.AddField("지각자");

    hnwExtQuery.SendField(response);

    // DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");

    if (voList.size() > 0) 
    {
        for (int i=0; i<voList.size(); i++) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_CNT"));
            hnwExtQuery.AddData(vo.getString("S_AT5_CNT"));
            hnwExtQuery.AddData(vo.getString("SAGO_CNT"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_E"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_T"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_F"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_Q"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_RUV"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_H"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_Z"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_I"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_AB"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_L"));
            hnwExtQuery.AddData(vo.getString("ENO_NO_C"));
            hnwExtQuery.SendData(response);
            
            if ( vo.getString("GBN2_TAG").equals("1") ) {
                if ( vo.getString("ENO_NO_CNT").equals("") ){} else { eno_no_cnt1 = eno_no_cnt1 + Integer.parseInt(vo.getString("ENO_NO_CNT")); }
                if ( vo.getString("S_AT5_CNT" ).equals("") ){} else { s_at5_cnt1  = s_at5_cnt1  + Integer.parseInt(vo.getString("S_AT5_CNT")); }  
                if ( vo.getString("SAGO_CNT"  ).equals("") ){} else { sago_cnt1   = sago_cnt1   + Integer.parseInt(vo.getString("SAGO_CNT")); }

                if ( vo.getString("ENO_NO_E"  ).equals("") ){} else { eno_no_e1   = eno_no_e1 + 1; }
                if ( vo.getString("ENO_NO_T"  ).equals("") ){} else { eno_no_t1   = eno_no_t1 + 1; }
                if ( vo.getString("ENO_NO_F"  ).equals("") ){} else { eno_no_f1   = eno_no_f1 + 1; }
                if ( vo.getString("ENO_NO_Q"  ).equals("") ){} else { eno_no_q1   = eno_no_q1 + 1; }
                if ( vo.getString("ENO_NO_RUV").equals("") ){} else { eno_no_ruv1 = eno_no_ruv1 + 1; }
                if ( vo.getString("ENO_NO_H"  ).equals("") ){} else { eno_no_h1   = eno_no_h1 + 1; }
                if ( vo.getString("ENO_NO_Z"  ).equals("") ){} else { eno_no_z1   = eno_no_z1 + 1; }
                if ( vo.getString("ENO_NO_I"  ).equals("") ){} else { eno_no_i1   = eno_no_i1 + 1; }
                if ( vo.getString("ENO_NO_AB" ).equals("") ){} else { eno_no_ab1  = eno_no_ab1 + 1; }
                if ( vo.getString("ENO_NO_L"  ).equals("") ){} else { eno_no_l1   = eno_no_l1 + 1; }
                if ( vo.getString("ENO_NO_C"  ).equals("") ){} else { eno_no_c1   = eno_no_c1 + 1; }

            } else {
                if ( vo.getString("ENO_NO_CNT").equals("") ){} else { eno_no_cnt2 = eno_no_cnt2 + Integer.parseInt(vo.getString("ENO_NO_CNT")); }
                if ( vo.getString("S_AT5_CNT" ).equals("") ){} else { s_at5_cnt2  = s_at5_cnt2  + Integer.parseInt(vo.getString("S_AT5_CNT")); }
                if ( vo.getString("SAGO_CNT"  ).equals("") ){} else { sago_cnt2   = sago_cnt2   + Integer.parseInt(vo.getString("SAGO_CNT")); }

                if ( vo.getString("ENO_NO_E"  ).equals("") ){} else { eno_no_e2   = eno_no_e2 + 1; }
                if ( vo.getString("ENO_NO_T"  ).equals("") ){} else { eno_no_t2   = eno_no_t2 + 1; }
                if ( vo.getString("ENO_NO_F"  ).equals("") ){} else { eno_no_f2   = eno_no_f2 + 1; }
                if ( vo.getString("ENO_NO_Q"  ).equals("") ){} else { eno_no_q2   = eno_no_q2 + 1; }
                if ( vo.getString("ENO_NO_RUV").equals("") ){} else { eno_no_ruv2 = eno_no_ruv2 + 1; }
                if ( vo.getString("ENO_NO_H"  ).equals("") ){} else { eno_no_h2   = eno_no_h2 + 1; }
                if ( vo.getString("ENO_NO_Z"  ).equals("") ){} else { eno_no_z2   = eno_no_z2 + 1; }
                if ( vo.getString("ENO_NO_I"  ).equals("") ){} else { eno_no_i2   = eno_no_i2 + 1; }
                if ( vo.getString("ENO_NO_AB" ).equals("") ){} else { eno_no_ab2  = eno_no_ab2 + 1; }
                if ( vo.getString("ENO_NO_L"  ).equals("") ){} else { eno_no_l2   = eno_no_l2 + 1; }
                if ( vo.getString("ENO_NO_C"  ).equals("") ){} else { eno_no_c2   = eno_no_c2 + 1; }

            }

        }

        hnwExtQuery.AddData("본사");
        hnwExtQuery.AddData(Integer.toString(eno_no_cnt1));
        hnwExtQuery.AddData(Integer.toString(s_at5_cnt1));
        hnwExtQuery.AddData(Integer.toString(sago_cnt1));
        hnwExtQuery.AddData(Integer.toString(eno_no_e1));
        hnwExtQuery.AddData(Integer.toString(eno_no_t1));
        hnwExtQuery.AddData(Integer.toString(eno_no_f1));
        hnwExtQuery.AddData(Integer.toString(eno_no_q1));
        hnwExtQuery.AddData(Integer.toString(eno_no_ruv1));
        hnwExtQuery.AddData(Integer.toString(eno_no_h1));
        hnwExtQuery.AddData(Integer.toString(eno_no_z1));
        hnwExtQuery.AddData(Integer.toString(eno_no_i1));
        hnwExtQuery.AddData(Integer.toString(eno_no_ab1));
        hnwExtQuery.AddData(Integer.toString(eno_no_l1));
        hnwExtQuery.AddData(Integer.toString(eno_no_c1));
        hnwExtQuery.SendData(response); 

        hnwExtQuery.AddData("지방");
        hnwExtQuery.AddData(Integer.toString(eno_no_cnt2));
        hnwExtQuery.AddData(Integer.toString(s_at5_cnt2)); 
        hnwExtQuery.AddData(Integer.toString(sago_cnt2)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_e2)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_t2));
        hnwExtQuery.AddData(Integer.toString(eno_no_f2));
        hnwExtQuery.AddData(Integer.toString(eno_no_q2));
        hnwExtQuery.AddData(Integer.toString(eno_no_ruv2));
        hnwExtQuery.AddData(Integer.toString(eno_no_h2));
        hnwExtQuery.AddData(Integer.toString(eno_no_z2));
        hnwExtQuery.AddData(Integer.toString(eno_no_i2));
        hnwExtQuery.AddData(Integer.toString(eno_no_ab2));
        hnwExtQuery.AddData(Integer.toString(eno_no_l2));
        hnwExtQuery.AddData(Integer.toString(eno_no_c2));
        hnwExtQuery.SendData(response);

        hnwExtQuery.AddData("일계");
        hnwExtQuery.AddData(Integer.toString(eno_no_cnt2 + eno_no_cnt1)); 
        hnwExtQuery.AddData(Integer.toString(s_at5_cnt2  + s_at5_cnt1));
        hnwExtQuery.AddData(Integer.toString(sago_cnt2   + sago_cnt1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_e2   + eno_no_e1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_t2   + eno_no_t1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_f2   + eno_no_f1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_q2   + eno_no_q1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_ruv2 + eno_no_ruv1));
        hnwExtQuery.AddData(Integer.toString(eno_no_h2   + eno_no_h1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_z2   + eno_no_z1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_i2   + eno_no_i1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_ab2  + eno_no_ab1));
        hnwExtQuery.AddData(Integer.toString(eno_no_l2   + eno_no_l1)); 
        hnwExtQuery.AddData(Integer.toString(eno_no_c2   + eno_no_c1)); 
        hnwExtQuery.SendData(response);

    }
}
%>