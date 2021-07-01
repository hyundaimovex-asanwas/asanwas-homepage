package common.menu.login.wrk;


import java.sql.Connection;

import hr.pir.c.pirc090.dao.PIRC090DAO;
import hr.but.a.buta020.dao.BUTA020MSDAO;

import javax.servlet.http.HttpSession;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.StringUtil;
import com.shift.gef.support.vo.GauceValueObject;

import common.menu.login.dao.LOGINDAO;
import common.util.DateUtil;
import common.util.DbManager;
import common.util.EncryptUtil;


public class LOGINWRK  {

    /**
     * LOGIN WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void LOGIN_SHR(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��������(����ȸ�� ��ȸ) DAO CLASS �޼��� ȣ�� * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //�н����� �ֹι�ȣ ��
        GauceDataSet ds = dao.LOGIN_SHR(p_box);
        GauceDataSet ds2 = dao.LOGIN_SHR_02(p_box);

        GauceDataRow grAdd = new GauceDataRow(ds2.getDataColCnt());

        for(int i=0; i<19; i++){
            grAdd.setString(i, "");
        }

        //�н������ �ֹι�ȣ�� ������ �н����� ������ �α����ؾ� ��
        if (ds.getDataRowCnt() == 1){

            /** Request ���� ���� **/
            HttpSession Session = p_req.getSession();
            if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(StringUtil.encrypt(p_box.get("KS_PASSWD")))) {
	            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//ȸ�����
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//���
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//����
	            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//�����ڵ�
	            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//���θ�
	            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//�Ҽ��ڵ�
	            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//�ҼӸ�
	            Session.setAttribute("SESSION_TEAMCD"   , GauceUtils.nameValue(ds, 1, "TEAM_CD"  ));   //���ڵ�
	            Session.setAttribute("SESSION_TEAMNM"   , GauceUtils.nameValue(ds, 1, "TEAM_NM"  ));   //��
	            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//�����
	            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//ȸ��Ҽ��ڵ�
	            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//ȸ��ҼӸ�
	            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//�����ڵ�
	            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//����
	            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//��å�ڵ�
	            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//��å
	            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//�ý��۳�¥


	            /*���� ���� �κ� �߰�*/
	            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //���� ���� �ڵ�


	            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //��������
	            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //��������
	            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //���±���
	            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //��������
	            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //�����ȹ����
	            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //�������񽺱���
	            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS����
	            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //�ܵ�����
	            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //�ܵ�����
	            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO" ));   //������������
	            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //�系�������
	            Session.setAttribute("SESSION_CETNO" , "");   //�系�������

	            Session.setAttribute("SESSION_GBN_CD" , GauceUtils.nameValue(ds, 1, "GBN_CD"));//�ٹ����ڵ�
            }

            //���� �����ð�
            Session.setMaxInactiveInterval(60*90);
            if (p_box.get("KS_PASSWD").equals("")) {//������ �н�����
                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

            //�ֹι�ȣ�� ������
            }else if(GauceUtils.nameValue(ds, 1, "CET_NO") == null || GauceUtils.nameValue(ds, 1, "CET_NO").length() == 0){
                //row�� 3���̸� ��й�ȣ �ʱ�ȭ�� ���� �ʾҴ�. emplist�� �ֹι�ȣ ���� (����row(1)�� +2�Ѵ�.)
                ds2.addDataRow(grAdd);
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

            //�ֹι�ȣ�� ����� �н����尡 ���� ����� �н������ ����� �Է� �н����尡 ������
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(GauceUtils.nameValue(ds, 1, "CET_NO").substring(7,14)) &&
                GauceUtils.nameValue(ds, 1, "PWD_NO").equals(p_box.get("KS_PASSWD"))) {
                //row���� 0�̸� �е���� �ٽ� ���
            	Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//ȸ�����
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//���
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//����
                p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());

            //����� �н������ ��ȣȭ ��Ų �н����尡 ������(�̹� ��ȣȭ�� �н����尡 db�� �־���Ѵ�)
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(StringUtil.encrypt(p_box.get("KS_PASSWD")))) {

                //�н����� Ʋ��Ƚ�� �ʱ�ȭ(pwd_hlc_cnt = 0), 5ȸ�̻� Ʋ���� �´���� �α��� ���Ѵ�. �׷��� �ʱ�ȭ ����
            	if(Integer.parseInt(GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT")) < 5){
            		dao.LOGIN_UPT_01(p_box);
            	}

                //�������� 90�� �������� �ٽ� �����ϰ�
                if(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD") != null &&
                  !GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD").trim().equals("") &&
                  Integer.parseInt(DateUtil.getAfterDate(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD"),0,0,90)) <= Integer.parseInt(DateUtil.getCurrentDateStr()) ){

                    //row�� 4���̸� ��й�ȣ�� �ٽ� �����ϰ� �Ѵ�.

                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);

                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

                }else{
                    //�������� �α���
                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
                }

            }else{
                //���̵� �н����尡 ��ġ���� �ʴ´�.(����ó���� �ʸ����� row���� üũ�ϰ� )
                //throw new BizException("����� ���̵�, �н����尡 ��ġ���� �ʽ��ϴ�.");
            	Session.setAttribute("SESSION_ENONO" ,  "");//���
            	Session.setAttribute("SESSION_ENONM" ,  "");//����
                //�н����� Ʋ��Ƚ�� ī���� ����(pwd_hlc_cnt+1)
                dao.LOGIN_UPT(p_box, GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT"));

                //row�� 2���̸� ���̵� �н����尡 ��ġ���� �ʴ´�.(����row(1)�� +1�Ѵ�.)
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
            }

        }else{
            //row�� 5���̸� ��ϵ� ����ڰ� �ƴ�
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
        }

    }

    
    
    /**
     * LOGIN WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void LOGIN_SHR_00(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��������(����ȸ�� ��ȸ) DAO CLASS �޼��� ȣ�� * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //�н����� �ֹι�ȣ ��
        GauceDataSet ds = dao.LOGIN_SHR(p_box);
        
		//System.out.println("1111111111111111111 !!!!" + GauceUtils.nameValue(ds, 1, "PWD_NO"));  
        
        GauceDataSet ds2 = dao.LOGIN_SHR_02(p_box);
      
		String PASSWD_SHA256 = EncryptUtil.SHA256Encrypt(p_box.get("KS_PASSWD"));        
        
        GauceDataRow grAdd = new GauceDataRow(ds2.getDataColCnt());

        for(int i=0; i<19; i++){
            grAdd.setString(i, "");
        }

        //�н������ �ֹι�ȣ�� ������ �н����� ������ �α����ؾ� ��
        if (ds.getDataRowCnt() == 1){

        	
    		//System.out.println("p_box !!!!" + EncryptUtil.SHA256Encrypt(p_box.get("KS_PASSWD")));           	
    		System.out.println("p_box1 !!!!" + PASSWD_SHA256);         
    		System.out.println("p_box2 !!!!" + GauceUtils.nameValue(ds, 1, "PWD_NO"));          		
    		
            /** Request ���� ���� **/
            HttpSession Session = p_req.getSession();
            if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(PASSWD_SHA256)) {
            	
        		//System.out.println("�̰��� ���� !!!!");              	               	
            	
	            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//ȸ�����
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//���
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//����
	            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//�����ڵ�
	            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//���θ�
	            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//�Ҽ��ڵ�
	            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//�ҼӸ�
	            Session.setAttribute("SESSION_TEAMCD"   , GauceUtils.nameValue(ds, 1, "TEAM_CD"  ));   //���ڵ�
	            Session.setAttribute("SESSION_TEAMNM"   , GauceUtils.nameValue(ds, 1, "TEAM_NM"  ));   //��
	            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//�����
	            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//ȸ��Ҽ��ڵ�
	            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//ȸ��ҼӸ�
	            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//�����ڵ�
	            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//����
	            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//��å�ڵ�
	            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//��å
	            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//�ý��۳�¥


	            /*���� ���� �κ� �߰�*/
	            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //���� ���� �ڵ�


	            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //��������
	            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //��������
	            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //���±���
	            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //��������
	            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //�����ȹ����
	            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //�������񽺱���
	            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS����
	            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //�ܵ�����
	            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //�ܵ�����
	            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO" ));   //������������
	            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //�系�������
	            Session.setAttribute("SESSION_CETNO" , "");   //�系�������

	            Session.setAttribute("SESSION_GBN_CD" , GauceUtils.nameValue(ds, 1, "GBN_CD"));//�ٹ����ڵ�
            }
       
            
            //���� �����ð�
            Session.setMaxInactiveInterval(60*90);
            if (p_box.get("KS_PASSWD").equals("")) {//������ �н�����
                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

            //�ֹι�ȣ�� ������
            }else if(GauceUtils.nameValue(ds, 1, "CET_NO") == null || GauceUtils.nameValue(ds, 1, "CET_NO").length() == 0){
                //row�� 3���̸� ��й�ȣ �ʱ�ȭ�� ���� �ʾҴ�. emplist�� �ֹι�ȣ ���� (����row(1)�� +2�Ѵ�.)
                ds2.addDataRow(grAdd);
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

            //�ֹι�ȣ�� ����� �н����尡 ���� ����� �н������ ����� �Է� �н����尡 ������
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(GauceUtils.nameValue(ds, 1, "CET_NO").substring(7,14)) &&
                GauceUtils.nameValue(ds, 1, "PWD_NO").equals(p_box.get("KS_PASSWD"))) {
                //row���� 0�̸� �е���� �ٽ� ���
            	Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//ȸ�����
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//���
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//����
                p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());

            //����� �н������ ��ȣȭ ��Ų �н����尡 ������(�̹� ��ȣȭ�� �н����尡 db�� �־���Ѵ�)
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(PASSWD_SHA256)) {

            	
        		//System.out.println("�̰͵� �� ���� !!!!");                  	
            	
                //�н����� Ʋ��Ƚ�� �ʱ�ȭ(pwd_hlc_cnt = 0), 5ȸ�̻� Ʋ���� �´���� �α��� ���Ѵ�. �׷��� �ʱ�ȭ ����
            	if(Integer.parseInt(GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT")) < 5){
            		dao.LOGIN_UPT_01(p_box);
            	}

                //�������� 90�� �������� �ٽ� �����ϰ�
                if(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD") != null &&
                  !GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD").trim().equals("") &&
                  Integer.parseInt(DateUtil.getAfterDate(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD"),0,0,90)) <= Integer.parseInt(DateUtil.getCurrentDateStr()) ){

                    //row�� 4���̸� ��й�ȣ�� �ٽ� �����ϰ� �Ѵ�.

                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);

                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

                }else{
                    //�������� �α���
                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
                }

            }else{
                //���̵� �н����尡 ��ġ���� �ʴ´�.(����ó���� �ʸ����� row���� üũ�ϰ� )
                //throw new BizException("����� ���̵�, �н����尡 ��ġ���� �ʽ��ϴ�.");
            	Session.setAttribute("SESSION_ENONO" ,  "");//���
            	Session.setAttribute("SESSION_ENONM" ,  "");//����
                //�н����� Ʋ��Ƚ�� ī���� ����(pwd_hlc_cnt+1)
                dao.LOGIN_UPT(p_box, GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT"));

                //row�� 2���̸� ���̵� �н����尡 ��ġ���� �ʴ´�.(����row(1)�� +1�Ѵ�.)
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
            }

        }else{
            //row�� 5���̸� ��ϵ� ����ڰ� �ƴ�
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
        }

    }    
    
    
    /**
     * LOGIN WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void LOGIN_SHR_03(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��������(����ȸ�� ��ȸ) DAO CLASS �޼��� ȣ�� * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //�н����� �ֹι�ȣ ��
        GauceDataSet ds = dao.LOGIN_SHR(p_box);

        //�н������ �ֹι�ȣ�� ������ �н����� ������ �α����ؾ� ��
        if (ds.getDataRowCnt() == 1){
            /** Request ���� ���� **/
            HttpSession Session = p_req.getSession();
            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//ȸ�����
            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//���
            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//����
            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//�����ڵ�
            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//���θ�
            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//�Ҽ��ڵ�
            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//�ҼӸ�
            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//�����
            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//ȸ��Ҽ��ڵ�
            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//ȸ��ҼӸ�
            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//�����ڵ�
            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//����
            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//��å�ڵ�
            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//��å
            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//�ý��۳�

            /*���� ���� �κ� �߰�*/
            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //���� ���� �ڵ�
            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //��������
            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //��������
            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //���±���
            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //��������
            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //�����ȹ����
            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //�������񽺱���
            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS����
            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //�ܵ�����
            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //�ܵ�����
            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO"));    //������������
            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //�系�������

            //���� �����ð�
            Session.setMaxInactiveInterval(60*90);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

        }else{
            p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());
        }

    }


		public void LOGIN_SHR_05(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);


			 p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_05(p_box));

		}


		public void LOGIN_UPT_05(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);

			  dao.LOGIN_UPT_05(p_box);
			 // dao.LOGIN_INS_05(p_box);

				GauceDataSet dsGW = dao.LOGIN_SHR_05(p_box);

	            Connection conn = DbManager.getGrwConnection();// MS SQL ����
	        try {

	            BUTA020MSDAO msDao = new BUTA020MSDAO(p_tr);

	            msDao.BUTA020_SMS_SAV(conn, p_box, dsGW );//G/W SMS Master �� ����

			} catch(Exception e) {
	    			throw new CException(e.getMessage());
			} finally {
				try{
					conn.close();
				}catch(Exception e){e.printStackTrace();}
			}
		}

		public void LOGIN_SHR_06(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);

			p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_06(p_box));
		}

		public void LOGIN_SHR_07(CBox p_box, TrBox p_tr) throws CException {

			LOGINDAO dao = new LOGINDAO("default", p_tr);

			p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_07(p_box));
		}

		public void LOGIN_UPT_06(CBox p_box, TrBox p_tr) throws CException {

			LOGINDAO dao = new LOGINDAO("default", p_tr);

			  dao.LOGIN_UPT_06(p_box);
		}


		/**
		 * GROUPWARE �α��������� �����ϴ� WORK�޼ҵ�
		 * @param p_box
		 * @param p_tr
		 * @throws CException
		 */
		public void GROUPWARE_SAV(CBox p_box, TrBox p_tr) throws CException {
			/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
			LOGINDAO dao = new LOGINDAO("default", p_tr);

			String GUN_YMD = p_box.get("GUN_YMD");
			String ENO_NO = p_box.get("ENO_NO");

			// �������� üũ
			GauceDataSet ds = dao.GROUPWARE_SHR_02(p_box);
			int rowCnt = ds.getDataRowCnt();
			System.out.println("�������� rowCnt [" + rowCnt + "]");
			if(rowCnt > 0){
				String DPT_CD = GauceUtils.nameValue(ds, 1, "DPT_CD");
				// �������Ͽ� Y �� ����
				dao.GROUPWARE_UPT_01(p_box);
				// T_DI_DILIGENCE �� ���� ������ �� ���� �ۼ�
				dao.GROUPWARE_INS_01(p_box, GUN_YMD, DPT_CD);
				// T_DI_DILIGENCE�� �����ڵ尪 ����
				dao.GROUPWARE_UPT_01(GUN_YMD, ENO_NO, "W", p_box);
				// T_DI_DILIGENCE�� �����Ѱ谪 ����
				dao.GROUPWARE_UPT_02(GUN_YMD, ENO_NO, p_box);
			}else{

			}

		}

}