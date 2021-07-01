<!--
***********************************************************************
* @source      : proa030_ED.jsp
* @description : ������������ ����(����) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15      ���м�        �����ۼ�. 
* 2007/05/08      ���м�        ������, �⵵������ �������� ����        
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

    String pmt_ymd     = request.getParameter("pmt_ymd");	
    String gbn_cd      = request.getParameter("gbn_cd");
    String jobdpt_val  = request.getParameter("jobdpt_val");
    String toe_cd      = request.getParameter("toe_cd");
    String rec_cd      = request.getParameter("rec_cd");
    String lan_cd      = request.getParameter("lan_cd");
    
    String toe_val    = "";
    String rec_val    = "";
    String lan_val    = "";
    String col_name   = "";

    // ��������
    if ( toe_cd.equals("2") ) {
        toe_val = "AND EXM_TIC < 550";
    } else if ( toe_cd.equals("3") ) {
        toe_val = "AND EXM_TIC >= 550";
    }
    // ��õ����
    if ( rec_cd.equals("2") ) {
        rec_val = "AND CEN_ENO IS NOT NULL";
    } else if ( rec_cd.equals("3") ) {
        rec_val = "AND CEN_ENO IS NULL";
    }
    // ���� ����κп� ǥ���� �λ��� �⵵�� ������������
    col_name  = "						 , DECODE(JPR_YY,1,SUBSTR(TO_CHAR("+pmt_ymd+"-1,'9999'),4,2)";
    col_name += "                                       ,2,SUBSTR(TO_CHAR("+pmt_ymd+"-2,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-1,'9999'),4,2)";
    col_name += "                                       ,3,SUBSTR(TO_CHAR("+pmt_ymd+"-3,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-2,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-1,'9999'),4,2)";
    col_name += "                                       ,4,SUBSTR(TO_CHAR("+pmt_ymd+"-4,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-3,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-2,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-1,'9999'),4,2)";
    col_name += "                                       ,  SUBSTR(TO_CHAR("+pmt_ymd+"-5,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-4,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-3,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-2,'9999'),4,2)||'  '||SUBSTR(TO_CHAR("+pmt_ymd+"-1,'9999'),4,2))   COL_NAME";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("pro", "PROA030_SHR_02");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        col_name, jobdpt_val, toe_val, rec_val
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        pmt_ymd, gbn_cd, pmt_ymd
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("no");
    hnwExtQuery.AddField("JOB_TITLE");
    hnwExtQuery.AddField("������,����� ���");
    hnwExtQuery.AddField("COL_NAME");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�ù��Ի���");
    hnwExtQuery.AddField("�׷��Ի���");
    hnwExtQuery.AddField("����б�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�����Ⱓ");
    hnwExtQuery.AddField("�λ���");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�ټ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("��õ");
    hnwExtQuery.AddField("�Ѱ�");
    hnwExtQuery.AddField("Ȯ��");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�����Ⱓ���");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int j = 0;
    String pre_job = "";
    String pre_jpr = "";
    String yy = "";
    int eno_cnt  = 0;
    int pre_eno_cnt = 0;
    int job_cnt  = 0;
    int job_cnt2 = 0;
    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            //------���������� row���� 20���� �������� ���������� �������� ������������ ������ ���� row�� ����Ÿ�� ����ִ´�--
//            if ( i == 0 || (vo.getString("JOB_NM").equals(pre_job) && vo.getString("JPR_YY").equals(pre_jpr)) ) {     ������,��������� �������� ����
            if ( i == 0 || (vo.getString("JOB_NM").equals(pre_job)) ) {
                job_cnt  = job_cnt + 1;
                job_cnt2 = job_cnt;
                if ( Integer.parseInt(vo.getString("CNT")) > eno_cnt )  {
                    eno_cnt  = Integer.parseInt(vo.getString("CNT"));
                }
            } else {
                job_cnt2 = job_cnt;
                job_cnt = 0;
                eno_cnt  = Integer.parseInt(vo.getString("CNT"));
            }

//            if ( job_cnt == 0 ) {         ������,��������� �������� ����
            if ( job_cnt == 0 && (job_cnt2)%20 != 0) {
                for ( k = 0; k < 20-j - ((job_cnt2)%20); k++ ) {
                    hnwExtQuery.AddData(Integer.toString(k+1)); 
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
                j = 1;
            }
            if ( (job_cnt2)%20 == 0 ) j = 1;
            //-------------------------------------------------------------------------------------------------------------------
            hnwExtQuery.AddData(Integer.toString(i+1)); 
    
            if ( vo.getString("JOB_NM").equals("5��") )  yy = " 5��";
            if ( vo.getString("JOB_NM").equals("4��") )  yy = " 4��";
            if ( vo.getString("JOB_NM").equals("�븮") ) yy = " 4��";
            if ( vo.getString("JOB_NM").equals("����") ) yy = " 5��";
            if ( vo.getString("JOB_NM").equals("����") ) yy = " 4��";
            if ( vo.getString("JOB_NM").equals("�δ�") ) yy = " 3��";
            
            hnwExtQuery.AddData(vo.getString("JOB_TITLE")+yy);

            hnwExtQuery.AddData(Integer.toString(eno_cnt));
            hnwExtQuery.AddData(vo.getString("COL_NAME"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("FJOB_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("JPR_VAL"));
            hnwExtQuery.AddData(vo.getString("GOG_VAL"));
            hnwExtQuery.AddData(vo.getString("GOG_TOT"));
            hnwExtQuery.AddData(vo.getString("GOG_HTT"));
            hnwExtQuery.AddData(vo.getString("GUN_GTT"));
            hnwExtQuery.AddData(vo.getString("EDU_SCR"));
            hnwExtQuery.AddData(vo.getString("SAN_SCR"));
            hnwExtQuery.AddData(vo.getString("CEN_SCR"));
            hnwExtQuery.AddData(vo.getString("SPC_TOT"));
            hnwExtQuery.AddData(vo.getString("SSS"));          //Ȯ��
            if ( lan_cd.equals("2") ) {
                hnwExtQuery.AddData("");
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("EXM_TIC"));
                hnwExtQuery.AddData(vo.getString("EXM_CMP"));
            }
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("JPR_YY"));
       
            hnwExtQuery.SendData(response);

            pre_job = vo.getString("JOB_NM");
            pre_jpr = vo.getString("JPR_YY");
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
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>