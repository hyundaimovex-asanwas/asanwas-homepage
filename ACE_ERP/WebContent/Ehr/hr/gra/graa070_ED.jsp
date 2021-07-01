<!--
***********************************************************************
* @source      : graa070_ED.jsp
* @description : 급상여소급처리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/25      김학수        최초작성.            
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String pis_yymm = request.getParameter("pis_yymm");	
    String occ_cd   = request.getParameter("occ_cd");
    String dpt_cd1  = request.getParameter("dpt_cd1");
    String dpt_cd2  = request.getParameter("dpt_cd2");
    String job_cd1  = request.getParameter("job_cd1");
    String job_cd2  = request.getParameter("job_cd2");
    String cd_gbn   = request.getParameter("cd_gbn");
    
    String toe_val    = "";
    String rec_val    = "";
    String lan_val    = "";                                                                               
    String col_name   = "";

    if ( dpt_cd1.equals("") || dpt_cd1 == null ) dpt_cd1 = "1";
    if ( dpt_cd2.equals("") || dpt_cd2 == null ) dpt_cd2 = "9999";
    if ( job_cd1.equals("") || job_cd1 == null ) job_cd1 = "1";
    if ( job_cd2.equals("") || job_cd2 == null ) job_cd2 = "9999";

    /** 조회 조건(급/상여, 근로구분)에 따른 처리 **/                                                          
    StringBuffer sb  = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    StringBuffer sb3 = new StringBuffer();
    StringBuffer sb4 = new StringBuffer();

    if( cd_gbn.equals("A4")){
        sb.append("AND    A.DPT_CD = C.COMM_CD \n");
        sb.append("             AND    C.SORT_NO BETWEEN '"+dpt_cd1+"' AND '"+dpt_cd2+"'");

        sb2.append("            A.DPT_NM									DPT_NM  ");	
        sb2.append("          , DECODE(INT,1,A.DPT_SEQ,A.DPT_SEQ)			DPT_SEQ ");    
        sb2.append("          , DECODE(INT,1,'소계',A.JOB_NM)				JOB_NM  ");	   
        sb2.append("          , DECODE(INT,1,'999',A.JOB_SEQ)				JOB_SEQ ");   
    
        sb3.append("            A.DPT_NM                                            "); 
        sb3.append("          , DECODE(INT,1,A.HEAD_SEQ,A.HEAD_SEQ)                 "); 
        sb3.append("          , DECODE(INT,1,A.DPT_SEQ,A.DPT_SEQ)                   "); 
        sb3.append("          , DECODE(INT,1,'소계',A.JOB_NM)                       "); 
        sb3.append("          , DECODE(INT,1,'999',A.JOB_SEQ)                       ");     

        sb4.append("          , DECODE(INT,1,A.DPT_SEQ,A.DPT_SEQ)                   "); 
        sb4.append("          , DECODE(INT,1,'999',A.JOB_SEQ)                       ");     
    }else if( cd_gbn.equals("A2")){
        sb.append("AND    A.JOB_CD = C.COMM_CD \n");
        sb.append("             AND    C.SORT_NO BETWEEN '"+job_cd1+"' AND NVL("+job_cd2+",'9999')");

        sb2.append("            A.JOB_NM									DPT_NM  ");	
        sb2.append("          , DECODE(INT,1,A.JOB_SEQ,A.JOB_SEQ)			DPT_SEQ ");    
        sb2.append("          , DECODE(INT,1,'소계',A.DPT_NM)				JOB_NM  ");	   
        sb2.append("          , DECODE(INT,1,'999',A.DPT_SEQ)				JOB_SEQ ");
        
        sb3.append("            A.JOB_NM                                            ");
        sb3.append("          , DECODE(INT,1,A.HEAD_SEQ,A.HEAD_SEQ)                 ");
        sb3.append("          , DECODE(INT,1,A.JOB_SEQ,A.JOB_SEQ)                   ");
        sb3.append("          , DECODE(INT,1,'소계',A.DPT_NM)                       ");
        sb3.append("          , DECODE(INT,1,'999',A.DPT_SEQ)                       ");
                                                                                    
        sb4.append("          , DECODE(INT,1,A.JOB_SEQ,A.JOB_SEQ)                   ");           
        sb4.append("          , DECODE(INT,1,'999',A.DPT_SEQ)                       ");
    }                                                                       

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gra", "GRAA070_SHR_PRINT");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb2.toString(), sb.toString(), sb3.toString(), sb4.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        pis_yymm, pis_yymm, pis_yymm, pis_yymm, cd_gbn, occ_cd
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("2월");
    hnwExtQuery.AddField("3월");
    hnwExtQuery.AddField("4월");
    hnwExtQuery.AddField("5월");
    hnwExtQuery.AddField("6월");
    hnwExtQuery.AddField("7월");
    hnwExtQuery.AddField("8월");
    hnwExtQuery.AddField("9월");
    hnwExtQuery.AddField("10월");
    hnwExtQuery.AddField("11월");
    hnwExtQuery.AddField("소계");
    hnwExtQuery.AddField("총계");
    hnwExtQuery.AddField("구분no");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int j = 0;
    int m = 1;
    String flag = "N";
    int temp_n = 0;
    String pre_job = "";
    String pre_jpr = "";
    String pre_eno = "";
    int eno_cnt  = 0;
    int pre_tot  = 0;
    int job_cnt  = 0;
    int job_cnt2 = 0;
    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            //------한페이지당 row개수 20개를 기준으로 직위에따른 페이지를 구분짓기위해 나머지 공백 row를 빈데이타로 집어넣는다--
            if ( i == 0 || (vo.getString("DPT_NM").equals(pre_job)) ) {
                job_cnt  = job_cnt + 1;
                job_cnt2 = job_cnt;
            } else {

                job_cnt2 = job_cnt;
                job_cnt = 0;
                flag = "Y";
            }
            
            if ( job_cnt == 0 ) {
                for ( k = 0; k < 40-j - ((job_cnt2)%40); k++ ) {
                    
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.AddData(vo.getString(""));
                    hnwExtQuery.SendData(response);

                }
                j = 1;
            }
            //-------------------------------------------------------------------------------------------------------------------
            if ( flag.equals("Y") ) {
                temp_n = 1;
            } else if ( flag.equals("N") ){
                temp_n = 0;
            }
            if ( vo.getString("ENO_NO").equals(pre_eno) ) {
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("DPT_NM"));
            }

            if ( vo.getString("ENO_NO").equals(pre_eno) ) {
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("JOB_NM"));
            }
            if ( vo.getString("JOB_NM").equals("소계") ) {
                m = m + 1;
                eno_cnt = job_cnt - m;
                if ( vo.getString("ENO_NO").equals(pre_eno) ) {
                    hnwExtQuery.AddData("");
                } else {
                    hnwExtQuery.AddData(Integer.toString(eno_cnt/2));
                }
            } else {
                m=-1;
                if ( vo.getString("ENO_NO").equals(pre_eno) ) {
                    hnwExtQuery.AddData("");     
                } else {
                    hnwExtQuery.AddData(vo.getString("ENO_NM"));
                }
            }
            hnwExtQuery.AddData(vo.getString("AMOUNT_02"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_03"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_04"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_05"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_06"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_07"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_08"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_09"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_10"));
            hnwExtQuery.AddData(vo.getString("AMOUNT_11"));
            hnwExtQuery.AddData(vo.getString("TOT1"));
            if ( job_cnt%2 == temp_n ) {
                hnwExtQuery.AddData(Integer.toString(pre_tot + Integer.parseInt(vo.getString("TOT1"))));
            } else {
                hnwExtQuery.AddData("");
            }

            hnwExtQuery.AddData(vo.getString("SAL_GBN"));

            hnwExtQuery.SendData(response);
            
            pre_tot = Integer.parseInt(vo.getString("TOT1"));
            pre_job = vo.getString("DPT_NM");
            pre_eno = vo.getString("ENO_NO");
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>