/*
package Ehr.yac.a.yaca099.wrk;

import Ehr.yac.a.yaca099.dao.YACA099DAO;
import Ehr.yac.a.yaca030.dao.YACA030DAO;


import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

//�߰�
import com.epapyrus.api.ExportCustomFile;
import com.dreamsecurity.exception.DVException;
import com.dreamsecurity.jcaos.util.encoders.Base64;
import com.dreamsecurity.verify.DSTSPDFSig;

import java.util.List;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.FileWriter;
import java.io.File;
import java.io.FileOutputStream;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.jdom2.*;
import org.jdom2.input.SAXBuilder;
*/

package Ehr.yac.a.yaca099.wrk;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

import Ehr.yac.a.yaca021.dao.YACA021DAO;
import Ehr.yac.a.yaca099.dao.YACA099DAO;
//import hr.yac.a.yaca021.wrk.YACA021WRK;
//import PDFExport.ezPDFExportFile;

import com.dreamsecurity.exception.DVException;
import com.dreamsecurity.jcaos.util.encoders.Base64;
import com.dreamsecurity.verify.DSTSPDFSig;

import com.epapyrus.api.ExportCustomFile;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

//import common.file.wrk.FILEWRK;
//import etiming.astdts.apl3161.CertVerifyConst;
//import etiming.astdts.apl3161.TSSPdfTSTValidator;


import Ehr.yac.a.yaca020.dao.YACA020DAO;
import Ehr.yac.a.yaca021.dao.YACA021DAO;
import Ehr.yac.a.yaca021.wrk.YACA021WRK;

public class YACA099WRK {
    private YACA099DAO dao = null;
    private String connectionName = "default";
    
    
    /**
     * ���� ��ȯ
     * @param p_box
     * @throws CException
     * @throws IOException
     * @throws NumberFormatException 
     * @throws JDOMException
     */
    public void YACA099_FILE(CBox p_box, TrBox p_tr) throws CException, IOException, NumberFormatException, JDOMException {

        String xml = null;
        GauceDataSet[] rtnDS = null;
        GauceDataSet   dsRESULT = new GauceDataSet();    //���� ��ȯ ���� ���� ����
        GauceDataSet   dsT_AC_FAMILY = new GauceDataSet();
        GauceDataRow   row = null;

        GauceDataColumn[] cols = {
                new GauceDataColumn("RESULT",  ColumnProp.COLUMN_TYPE_STRING)
        };
        dsRESULT.addDataColumns(cols);
        
        
        System.out.println("YACA099_FILE::CET_NO"+p_box.get("CET_NO"));
        //���ڹ��� ���� > xml �� ��ȯ (���������Ͽ�, ������ ���� ���� ����)
        xml = getData(p_box.get("PIS_YY"), p_box.get("ENO_NO"), p_box.get("FILE_URL"),  p_box.get("CET_NO"));
        
        if(xml.substring(0,2).equals("NG")) {  //�������� ��� >>> ���� �޼��� ����
            row = dsRESULT.newDataRow();
            row.addColumnValue(xml);
            dsRESULT.addDataRow(row);
        }else {
            row = dsRESULT.newDataRow();
            row.addColumnValue("OK");
            dsRESULT.addDataRow(row);
            
            //xml �Ľ��Ͽ� �����ͼ����� ��ȯ
            rtnDS = ConvertXml(xml, p_box.get("PIS_YY"), p_box.get("ENO_NO"), p_box.get("FILE_SEQ"),p_box.get("CET_NO"));
            
            dsT_AC_FAMILY = rtnDS[0];
        }
        
        p_tr.setOutDataSet("dsRESULT" , dsRESULT);
        p_tr.setOutDataSet("dsT_AC_FAMILY_FILE" , dsT_AC_FAMILY);
        
    }
    
    /** �Է¹��� PDF ������ ���ڹ��� XML ���·� ��ȯ 
     * 20151208 2015��ͼӺ� ����
     * @throws CException 
     * @throws IOException 
     * @throws JDOMException **/
    public String getData(String pis_yy, String eno_no, String file_url, String cet_no) throws CException, IOException, JDOMException {
        
    	//System.out.println("getData");
    	
        Configuration conf = Configuration.getInstance();
        String FILEURL     = conf.get("framework.file.upload.pds");
        String fullpath    = file_url;
        byte[] buff        = new byte[1024];
        int bytesRead      = 0;
        ByteArrayOutputStream bao = null;
        String rtnXml      = null; //��� xml
        String p_pwd       = null; //��ȣȭ�� ������ ���� ��й�ȣ. ���� �Է¹��� �Ķ��Ÿ �� �ѱ�� or �ֹι�ȣ�� �ڵ� ����
        String errorMsg    = null; //������ �����޽���
        boolean isSuccess = false;
        String key = "XML";
        
        File file = new File (fullpath);
        FileInputStream fin = new FileInputStream(file);
        bao = new ByteArrayOutputStream();
                
        while ((bytesRead = fin.read(buff)) > 0) {
            bao.write(buff, 0, bytesRead);
        }
        byte[] fileByte = bao.toByteArray();
        
        fin.close();
        bao.close();
        
        if(!file_url.toUpperCase().endsWith(".PDF")) {
            errorMsg = "PDF������ �ƴϰų� �ջ�� �����Դϴ�.";
            rtnXml = "����";
        }
        
        /* [Step1] ���ڹ��� ������ ���� */
        try {
        	
        	System.out.println("[Step1] ���ڹ��� ������ ����");
        	
            DSTSPDFSig dstsPdfsig = new DSTSPDFSig();
            
            dstsPdfsig.init(fileByte);
            dstsPdfsig.tokenParse();

            isSuccess = dstsPdfsig.tokenVerify();
            
            if( isSuccess ) {
                System.out.println("<!-- ���� �Ϸ�(����) -->");
            } else {
                String msg = dstsPdfsig.getTstVerifyFailInfo();
                System.out.println(msg);
                errorMsg = msg;
                rtnXml = "����";
            }
        } catch (DVException e) {
            System.out.println("���� �ڵ� : "+ e.getLastError());
            System.out.println("���� �޽��� : "+ e.getMessage());
            
            errorMsg = "���� �ڵ� : "+ e.getLastError()+"  ���� �޽��� : "+ e.getMessage();
            rtnXml = "����";
        }
        
        /* [Step2] XML(or SAM) ������ ���� */

        try {
        	
        	System.out.println("[Step2] XML(or SAM) ������ ���� ");
            if (isSuccess) {
                ExportCustomFile pdf = new ExportCustomFile();
                
                System.out.println("fileByte:" +fileByte);
                System.out.println("p_pwd:"+p_pwd);
                System.out.println("key:"+key);
                System.out.println("---------------------");
    
                // ������ ����
                //���ÿ�
                //byte[] buf = pdf.NTS_GetFileBufEx(fileByte, p_pwd, key, true );
                
                //������
                byte[] buf = pdf.NTS_GetFileBufEx(fileByte, p_pwd, key, false );
                int v_ret = pdf.NTS_GetLastError();
                
                
                System.out.println("v_ret:: "+v_ret);
    
                if (v_ret == 1||v_ret==-2) {
                	//���ÿ�
                    //String strXml = new String( buf, "EUC-KR" );
                	//������
                    String strXml = new String( buf, "UTF-8" );
                    // ���������� ����� ������ Ȱ���ϴ� ���� ���� �κ�
                    System.out.print(strXml);   // ���������� ȭ�鿡 ���
                    rtnXml = strXml;
                    
                    InputStream    in = null;    
                    
                    in = new ByteArrayInputStream(strXml.getBytes());
                    SAXBuilder builder = new SAXBuilder();
                    Document doc = builder.build(in);
                    
                    Element xmlRoot = doc.getRootElement();
                    List<Element> formList = xmlRoot.getChildren();
                    Element docEle = (Element)formList.get(0);
                    pis_yy = "2015";
                    
                    //System.out.println("doc_type : "+ docEle.getChildTextTrim("doc_type"));
                    //System.out.println("att_year : "+ docEle.getChildTextTrim("att_year"));
                    
                    //���ڹ��� Ȯ��
                    if(!docEle.getChildTextTrim("doc_type").equals("A")&&!docEle.getChildTextTrim("doc_type").equals("B")&&!docEle.getChildTextTrim("doc_type").equals("D")) {  //B.�⺻���� D.�󼼳���
                        rtnXml = "NG : �⺻������ ����ϼ���.";
                    }else if(!docEle.getChildTextTrim("att_year").equals(pis_yy)) {     //�ͼӿ���
                        rtnXml = "NG  : �ͼӿ����� �ڷḦ ����ϼ���.";
                    }
                    
                } else if (v_ret == 0) {
                    System.out.println("�������갣��ȭ ǥ�� ���ڹ����� �ƴմϴ�.");
                    errorMsg = "�������갣��ȭ ǥ�� ���ڹ����� �ƴմϴ�.";
                    rtnXml = "����";
                } else if (v_ret == -1) {
                    System.out.println("��й�ȣ�� Ʋ���ϴ�.");
                    errorMsg = "��й�ȣ�� Ʋ���ϴ�.";
                    rtnXml = "����";
                } else if (v_ret == -2) {
                    System.out.println("PDF������ �ƴϰų� �ջ�� �����Դϴ�.");
                    errorMsg = "PDF������ �ƴϰų� �ջ�� �����Դϴ�.";
                    rtnXml = "����";
                } else {
                    System.out.println("������ ���⿡ �����Ͽ����ϴ�.");
                    errorMsg = "������ ���⿡ �����Ͽ����ϴ�.";
                    rtnXml = "����";
                }
            }
            
        } catch (Exception e) {
            System.out.println("[Step2] ������ ���� ����(" + e.toString() + ")");
            errorMsg = "[Step2] ������ ���� ����(" + e.toString() + ")";
            rtnXml = "����";
        }
        
        if(rtnXml == "����") {
            rtnXml = "NG "+rtnXml +" : "+ errorMsg;
        }
        
        return rtnXml;
    }
      
    /** FAMILY �����ͼ� �˻��ϸ� �ش� ���� ��ϵǾ��ִ��� ��ȸ **
     *  ��ϵǾ�������   >>> ��ϵ� row(SEQ) ����
     *  ��ϾȵǾ������� >>> ��� ��, row(SEQ) ����            **/
    public String FamilySearch(GauceDataSet ds, String pis_yy, String eno_no, String nam_kor, String cet_no, String file_seq) {
        
        String  seq_no = "";
        int     r_yn   = -1;
        GauceDataRow   drFAMILY      = new GauceDataRow(ds.getDataColCnt());
        GauceDataRow   drRow         = new GauceDataRow(ds.getDataColCnt());
        
        System.out.println("FamilySearch:ds.getDataRowCnt():"+ds.getDataRowCnt());
        
        for(int r=0; r<ds.getDataRowCnt(); r++) {
            drRow = ds.getDataRow(r);
            System.out.println("r::"+r+"::cet_no::::"+cet_no);
            
            if(drRow.getString(3).equals(cet_no)) {  //������ row�� 3��° �׸��� �ֹι�ȣ
            	
            	System.out.println("equals");
                r_yn = r;
                break;
            }
        }
        
        if(r_yn >= 0) {
        	System.out.println("r_yn >= 0");
            seq_no = Integer.toString(r_yn);
        }else {
            seq_no = Integer.toString(ds.getDataRowCnt());
            
            System.out.println("000000seq_no::::::::::::"+seq_no);
            
            drFAMILY.setString(0, pis_yy);      //�ش�⵵ p_box.get("PIS_YY")
            drFAMILY.setString(1, eno_no);      //���
            drFAMILY.setString(2, nam_kor);     //�̸�
            drFAMILY.setString(3, cet_no);      //�ֹι�ȣ
            drFAMILY.setString(4, seq_no);      //�Ϸù�ȣ
            drFAMILY.setString(19, file_seq);   //FILE_SEQ
            
            ds.addDataRow(drFAMILY);
        }
        
        return seq_no;
    }
    
    /** xml �Ľ� 
     * @throws IOException 
     * @throws JDOMException 
     * @throws CException 
     * @throws NumberFormatException **/
    public GauceDataSet[] ConvertXml(String xml, String pis_yy, String eno_no, String file_seq, String i_cet_no) throws JDOMException, IOException, NumberFormatException, CException {
        
    	
    	System.out.println("GauceDataSet[] ConvertXml:::pis_yy"+pis_yy+"::"+eno_no);
    	
        InputStream    in = null;        
        GauceDataSet   dsT_AC_FAMILY    = new GauceDataSet();
        
        /*
        GauceDataSet   dsT_AC_MEDICAL   = new GauceDataSet();
        GauceDataRow   drMEDICAL        = null;
        GauceDataSet   dsT_AC_PENSION   = new GauceDataSet();
        GauceDataRow   drPENSION        = null;
        GauceDataSet   dsT_AC_DONATION  = new GauceDataSet();
        GauceDataRow   drDONATION       = null;    
        GauceDataSet   dsT_AC_INSURANCE  = new GauceDataSet();
        GauceDataRow   drINSURANCE       = null;  
        */
        
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PIS_YY",             GauceDataColumn.TB_STRING ));//0.�ش�⵵
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ENO_NO",             GauceDataColumn.TB_STRING ));//1.���
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("NAM_KOR",            GauceDataColumn.TB_STRING ));//2.�̸�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CET_NO",             GauceDataColumn.TB_STRING ));//3.�ֹι�ȣ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("SEQ_NO",             GauceDataColumn.TB_STRING ));//4.�Ϸù�ȣ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_AMT_NTS",       GauceDataColumn.TB_STRING ));//5.�ſ�ī����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("DIR_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//6.����ī����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CASH_AMT_NTS",       GauceDataColumn.TB_STRING ));//7.���ݿ�����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("MARKET_AMT_NTS",     GauceDataColumn.TB_STRING ));//8.���������ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PUBLIC_AMT_NTS",     GauceDataColumn.TB_STRING ));//9.���߱�����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_FH_AMT",   GauceDataColumn.TB_STRING ));//10.���� 2015��ݱ� �ſ�ī��� ���� 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_SH_AMT",   GauceDataColumn.TB_STRING ));//11.���� 2015�Ϲݱ� �ſ�ī��� ���� 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_AMT",      GauceDataColumn.TB_STRING ));//12.���� 2015 �ſ�ī��� ���� 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_FH_OVER",  GauceDataColumn.TB_STRING ));//13.���� 2015��ݱ� �߰�����������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_SH_OVER",  GauceDataColumn.TB_STRING ));//14.���� 2015�Ϲݱ� �߰�����������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2013_AMT",      GauceDataColumn.TB_STRING ));//15.���� 2013 �ſ�ī��� ���� 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2014_AMT",      GauceDataColumn.TB_STRING ));//16.���� 2014 �ſ�ī��� ���� 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2013_OVER",     GauceDataColumn.TB_STRING ));//17.���� 2013 �߰�����������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2014_OVER",     GauceDataColumn.TB_STRING ));//18.���� 2014�߰�����������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FILE_SEQ",           GauceDataColumn.TB_STRING ));//19.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FORM_CD",            GauceDataColumn.TB_STRING ));//20.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("GB_CD",              GauceDataColumn.TB_STRING ));//21.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("TOT_AMT",            GauceDataColumn.TB_STRING ));//22.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("MARKET_TOT_AMT",     GauceDataColumn.TB_STRING ));//23.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("TMONEY_TOT_AMT",     GauceDataColumn.TB_STRING ));//24.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CF_TOT_AMT",         GauceDataColumn.TB_STRING ));//25.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CF_MARKET_TOT_AMT",  GauceDataColumn.TB_STRING ));//26.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CF_TMONEY_TOT_AMT",  GauceDataColumn.TB_STRING ));//27.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CS_TOT_AMT",         GauceDataColumn.TB_STRING ));//28.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CS_MARKET_TOT_AMT",  GauceDataColumn.TB_STRING ));//29.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CS_TMONEY_TOT_AMT",  GauceDataColumn.TB_STRING ));//30.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PR_TOT_AMT",         GauceDataColumn.TB_STRING ));//31.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PR_MARKET_TOT_AMT",  GauceDataColumn.TB_STRING ));//32.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PR_TMONEY_TOT_AMT",  GauceDataColumn.TB_STRING ));//33.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FT_TOT_AMT",         GauceDataColumn.TB_STRING ));//34.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FT_MARKET_TOT_AMT",  GauceDataColumn.TB_STRING ));//35.FILE_SEQ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FT_TMONEY_TOT_AMT",  GauceDataColumn.TB_STRING ));//36.FILE_SEQ
        
        
        /*
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PIS_YY",   GauceDataColumn.TB_STRING ));//0.�ش�⵵
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ENO_NO",   GauceDataColumn.TB_STRING ));//1.���
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("NAM_KOR",  GauceDataColumn.TB_STRING ));//2.�̸�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CET_NO",   GauceDataColumn.TB_STRING ));//3.�ֹι�ȣ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("SEQ_NO",   GauceDataColumn.TB_STRING ));//4.�Ϸù�ȣ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LIN_AMT_NTS",   GauceDataColumn.TB_STRING ));//5.�����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LIH_AMT_NTS",   GauceDataColumn.TB_STRING ));//6.����κ����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("MED_AMT_NTS",   GauceDataColumn.TB_STRING ));//7.�Ƿ��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LEN_AMT_NTS",   GauceDataColumn.TB_STRING ));//8.�÷º������Ƿ��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("EDU_TAG_NTS",   GauceDataColumn.TB_STRING ));//9.�����񱸺�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("EDU_AMT_NTS",   GauceDataColumn.TB_STRING ));//10.������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("HED_AMT_NTS",   GauceDataColumn.TB_STRING ));//11.�����Ư��������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("UNF_AMT_NTS",   GauceDataColumn.TB_STRING ));//12.������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_AMT_NTS",  GauceDataColumn.TB_STRING ));//13.�ſ�ī����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CASH_AMT_NTS",  GauceDataColumn.TB_STRING ));//14.���ݿ�����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("DIR_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//15.����ī����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("market_amt_nts",   GauceDataColumn.TB_STRING ));//16.���������ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("public_amt_nts",   GauceDataColumn.TB_STRING ));//17.���߱�����ݾ�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH1_AMT_NTS",   GauceDataColumn.TB_STRING ));//18.�����������Ա� �����ݻ�ȯ��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHO_AMT_NTS",   GauceDataColumn.TB_STRING ));//19.���ø������� (û������)
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHP_AMT_NTS",   GauceDataColumn.TB_STRING ));//20.����û����������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHR_AMT_NTS",   GauceDataColumn.TB_STRING ));//21.�ٷ������ø�������
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHM_AMT_NTS",   GauceDataColumn.TB_STRING ));//22.�� �ȵ�� ���� ���ڻ�ȯ��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LC3_AMT_NTS",   GauceDataColumn.TB_STRING ));//23.������α�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LC2_AMT_NTS",   GauceDataColumn.TB_STRING ));//24.������α�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LAST_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//25.������ �ſ�ī�� ����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LAST_ADD_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//26.������ �߰������� ����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ADD_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//27.�߰������� ����
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH2_AMT04_NTS",   GauceDataColumn.TB_STRING ));//28.��������������Ա� ���ڻ�ȯ�� (2011������) 10~15��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH2_AMT_NTS",   GauceDataColumn.TB_STRING ));//29.��������������Ա� ���ڻ�ȯ�� (2011������) 15~30��
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH4_AMT_NTS",   GauceDataColumn.TB_STRING ));//30.��������������Ա� ���ڻ�ȯ�� (2011������) 30���̻�
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH7_AMT_NTS",   GauceDataColumn.TB_STRING ));//31.��������������Ա� ���ڻ�ȯ�� (2012������) �����ݸ� ���ġ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH8_AMT_NTS",   GauceDataColumn.TB_STRING ));//32.��������������Ա� ���ڻ�ȯ�� (2012������) ��Ÿ
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FILE_SEQ",      GauceDataColumn.TB_STRING ));//33.FILE_SEQ
        */
         
        GauceDataRow drRow = new GauceDataRow(dsT_AC_FAMILY.getDataColCnt());
                
        int mm      = 0; 
        int pen_row = 1;
        
        String seq_no = ""; //�Ϸù�ȣ
        String name   = ""; //�̸�
        String cet_no = ""; //�ֹι�ȣ
        
        String form_cd ="";
        String gb_cd ="";
        
        int tot_amt=0;
        int market_tot_amt=0;
        int tmoney_tot_amt=0;
        
        int cf_tot_amt=0;
        int cf_market_tot_amt=0;
        int cf_tmoney_tot_amt=0;
        
        int cs_tot_amt=0;
        int cs_market_tot_amt=0;
        int cs_tmoney_tot_amt=0;
        
        int pr_tot_amt=0;
        int pr_market_tot_amt=0;
        int pr_tmoney_tot_amt=0;
                
        int ft_tot_amt=0;
        int ft_market_tot_amt=0;
        int ft_tmoney_tot_amt=0;
        
        
        
        
        
        int card_amt_nts     = 0; //�ſ�ī�����
        int cash_amt_nts     = 0; //���ݿ�����
        int dir_card_amt_nts = 0; //����ī�����
        int market_amt_nts      = 0; //����������
        int public_amt_nts   = 0; //���߱����̿��
        
        
        int card_2015_fh_amt = 0;  //���� 2015��ݱ� �ſ�ī��� ���� 
        int card_2015_sh_amt = 0;  //���� 2015�Ϲݱ� �ſ�ī��� ���� 
        int card_2015_amt = 0;     //���� 2015 �ſ�ī��� ����       
        int card_2015_fh_over = 0; //���� 2015��ݱ� �߰�����������  	
        int card_2015_sh_over = 0; //���� 2015�Ϲݱ� �߰�����������  	
        int card_2013_amt = 0;     //���� 2013 �ſ�ī��� ����       	
        int card_2014_amt = 0;     //���� 2014 �ſ�ī��� ����           
        int card_2013_over = 0;    //���� 2013 �߰�����������        
        int card_2014_over = 0;    //���� 2014�߰�����������   
        
        
        int first_year_tot_amt =0;  //��ݱ� ���ݾ� �հ�
        int second_year_tot_amt =0; //�Ϲݱ� ���ݾ� �հ�
                
        //����
        int last_card_amt_nts   = 0; //������ �ſ�ī�� ����
        int last_add_card_amt_nts = 0; //������ �ſ�ī�� �߰������� ����
        int add_card_amt_nts    = 0; //�ſ�ī�� �߰������� ����
        //�߰� �ؾ���.
        
        
        int ftyr_tot_amt        = 0;  //�����⵵ �Ϲݰ������ݾ� (2013)
        int ftyr_market_tot_amt = 0;  //�����⵵ �������������ݾ� (2013)
        int ftyr_tmoney_tot_amt = 0;  //�����⵵ ���߱���������ݾ� (2013)
        
        
        int pre_tot_amt        = 0;  //�����⵵ �Ϲݰ������ݾ� (2014)
        int pre_market_tot_amt = 0;  //�����⵵ �������������ݾ� (2014)
        int pre_tmoney_tot_amt = 0;  //�����⵵ ���߱���������ݾ� (2014)
        
        
        
        
        in = new ByteArrayInputStream(xml.getBytes());
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(in);
        
        Element xmlRoot = doc.getRootElement();
        List<Element> formList = xmlRoot.getChildren();
        
        
        System.out.println("formList.size()::"+formList.size());
        
        for(int i = 1; i< formList.size(); i++) {
        	
            Element formEle = (Element)formList.get(i);
            List<Element> manList = formEle.getChildren();
            
            System.out.println("i::"+i+"::manList.size()::"+manList.size());
           
            
        
           //9. �ſ�ī�� (G103Y : �����հ�)
            if(formEle.getAttributeValue("form_cd").equals("G103Y")) {
            	form_cd ="�ſ�ī��";
                for(int j=0; j<manList.size(); j++) {
                    name = "";
                    cet_no = "";
                    seq_no = "";
                    gb_cd="";
                    
                    /////////////////////////////
                    tot_amt=0;
                    market_tot_amt=0;
                    tmoney_tot_amt=0;
                    
                    cf_tot_amt=0;
                    cf_market_tot_amt=0;
                    cf_tmoney_tot_amt=0;
                    
                    cs_tot_amt=0;
                    cs_market_tot_amt=0;
                    cs_tmoney_tot_amt=0;
                    
                    pr_tot_amt=0;
                    pr_market_tot_amt=0;
                    pr_tmoney_tot_amt=0;
                            
                    ft_tot_amt=0;
                    ft_market_tot_amt=0;
                    ft_tmoney_tot_amt=0;
                    ///////////////////////////////////
                    
                    
                    card_amt_nts = 0;
                    market_amt_nts  = 0;
                    public_amt_nts  = 0;                   
                    
                    last_card_amt_nts = 0;
                    last_add_card_amt_nts = 0 ;
                    add_card_amt_nts = 0;
                    
                    
                    ftyr_tot_amt        = 0;  //�����⵵ �Ϲݰ������ݾ� (2013)
                    ftyr_market_tot_amt = 0;  //�����⵵ �������������ݾ� (2013)
                    ftyr_tmoney_tot_amt = 0;  //�����⵵ ���߱���������ݾ� (2013)
                    
                    
                    pre_tot_amt = 0;
                    pre_market_tot_amt = 0;
                    pre_tmoney_tot_amt = 0;
                    
                    Element manEle_G103Y = (Element)manList.get(j);
                    List<Element> dataList_G103Y = manEle_G103Y.getChildren();
                    
                    name    = manEle_G103Y.getAttributeValue("name");   //�̸�
                    cet_no  = manEle_G103Y.getAttributeValue("resid");  //�ֹι�ȣ
                    
                    //System.out.println("name::"+name+":cet_no:"+cet_no+"::::"+manEle_G103Y.getAttributeValue("pre_tot_amt"));
                    
                    
                    //�߰�
                   
                    i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //������ ��� �ֹ� ��ȣ�� üũ 
                    if(i_cet_no.equals(cet_no)){
                    
                    	gb_cd ="1";
                    	
	                    if(!manEle_G103Y.getAttributeValue("pre_tot_amt").equals("")) {
		                    pr_tot_amt = pr_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("pre_tot_amt"));
		                    System.out.println("2");
	                    }
	                    if(!manEle_G103Y.getAttributeValue("pre_market_tot_amt").equals("")) {
		                    pr_market_tot_amt = pr_market_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("pre_market_tot_amt"));
		                    System.out.println("3");
	                    }
	                    if(!manEle_G103Y.getAttributeValue("pre_tmoney_tot_amt").equals("")) {
		                    pr_tmoney_tot_amt = pr_tmoney_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("pre_tmoney_tot_amt"));
		                    System.out.println("4");
	                    }
	                    if(!manEle_G103Y.getAttributeValue("ftyr_tot_amt").equals("")) {
		                    ft_tot_amt = ft_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("ftyr_tot_amt"));
		                    System.out.println("5");
	                    }
	                    if(!manEle_G103Y.getAttributeValue("ftyr_market_tot_amt").equals("")) {
		                    ft_market_tot_amt = ft_market_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("ftyr_market_tot_amt"));
		                    System.out.println("6");
	                    }
	                    if(!manEle_G103Y.getAttributeValue("ftyr_tmoney_tot_amt").equals("")) {
		                    ft_tmoney_tot_amt = ft_tmoney_tot_amt +Integer.parseInt(manEle_G103Y.getAttributeValue("ftyr_tmoney_tot_amt"));
		                    System.out.println("7");
	                    }
                    }
                    
                                        
                    //������ϾȵǾ������� �߰� �� seq ����
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);
                    
                    System.out.println("seq_no::"+seq_no);
                    
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));
                    
                    System.out.println("step1");
                    
                    /*
                    if(drRow.getString(8) == null) {
                        market_amt_nts = 0;
                    }else {
                        market_amt_nts = Integer.parseInt(drRow.getString(8)); //8.���������ݾ�
                    }
                    
                    System.out.println("step2");
                    if(drRow.getString(9) == null) {
                        public_amt_nts = 0;
                    }else {
                        public_amt_nts = Integer.parseInt(drRow.getString(9)); //9.���߱�����ݾ�
                    }
                    System.out.println("step3");
                    */
                  
                    System.out.println("step8");
                    
                    //���ε� �����Ϳ��� �������� �κ�
                    for(int k=0; k<dataList_G103Y.size(); k++) {
                        Element dataEle = (Element)dataList_G103Y.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.�Ϲ�
                        	tot_amt = tot_amt +  Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //�Ϲݱ�
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.�������
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //��ݱ�
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.���߱���
                        	 tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	 cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //��ݱ�
                        	 cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }
                    }
                    
                    System.out.println("step9"+pis_yy+"::"+eno_no);
                    
                    
                    drRow.setString(0, pis_yy);   //0.�ͼӳ⵵
                    drRow.setString(1, eno_no);   //1.���   
                    drRow.setString(20, form_cd);
                    drRow.setString(21, gb_cd);
                    drRow.setString(22, Integer.toString(tot_amt));
                    drRow.setString(23, Integer.toString(market_tot_amt));
                    drRow.setString(24, Integer.toString(tmoney_tot_amt));
                    drRow.setString(25, Integer.toString(cf_tot_amt));
                    drRow.setString(26, Integer.toString(cf_market_tot_amt));
                    drRow.setString(27, Integer.toString(cf_tmoney_tot_amt));
                    drRow.setString(28, Integer.toString(cs_tot_amt));
                    drRow.setString(29, Integer.toString(cs_market_tot_amt));
                    drRow.setString(30, Integer.toString(cs_tmoney_tot_amt));
                    drRow.setString(31, Integer.toString(pr_tot_amt));
                    drRow.setString(32, Integer.toString(pr_market_tot_amt));
                    drRow.setString(33, Integer.toString(pr_tmoney_tot_amt));
                    drRow.setString(34, Integer.toString(ft_tot_amt));
                    drRow.setString(35, Integer.toString(ft_market_tot_amt));
                    drRow.setString(36, Integer.toString(ft_tmoney_tot_amt));
                                  
                    //drRow.setString(16, Integer.toString(card_2014_amt));     //16.2014 ������ �ſ�ī�� ����
                    //drRow.setString(18, Integer.toString(card_2014_over));    //18.2014������ �߰������� ����  
                    
                    
                    //drRow.setString(25, Integer.toString(last_card_amt_nts));      //25.������ �ſ�ī�� ����
                    //drRow.setString(26, Integer.toString(last_add_card_amt_nts));  //26.������ �߰������� ����  
                    //drRow.setString(27, Integer.toString(add_card_amt_nts));       //27.�߰������� ����
                    
                    System.out.println("end");
                }
            }
            
           //10. ���ݿ����� (G204M : ����)
            else if(formEle.getAttributeValue("form_cd").equals("G204M")) {
            	
            	System.out.println("form_cd::"+formEle.getAttributeValue("form_cd"));
            	
            	form_cd ="���ݿ�����";
            	
                for(int j=0; j<manList.size(); j++) {
                	name = "";
                    cet_no = "";
                    seq_no = "";
                    gb_cd ="";
                    
                    /////////////////////////////
                    tot_amt=0;
                    market_tot_amt=0;
                    tmoney_tot_amt=0;
                    
                    cf_tot_amt=0;
                    cf_market_tot_amt=0;
                    cf_tmoney_tot_amt=0;
                    
                    cs_tot_amt=0;
                    cs_market_tot_amt=0;
                    cs_tmoney_tot_amt=0;
                    
                    pr_tot_amt=0;
                    pr_market_tot_amt=0;
                    pr_tmoney_tot_amt=0;
                            
                    ft_tot_amt=0;
                    ft_market_tot_amt=0;
                    ft_tmoney_tot_amt=0;
                    ///////////////////////////////////
                    
                    
                    
                    cash_amt_nts = 0;
                    market_amt_nts = 0;
                    public_amt_nts = 0;
                    last_card_amt_nts = 0;
                    last_add_card_amt_nts = 0 ;
                    add_card_amt_nts = 0;
                    pre_tot_amt = 0;
                    pre_market_tot_amt = 0;
                    pre_tmoney_tot_amt = 0; 
                    
                    Element manEle_G204M = (Element)manList.get(j);
                    List<Element> dataList_G204M = manEle_G204M.getChildren();
                    
                    name    = manEle_G204M.getAttributeValue("name");   //�̸�
                    cet_no  = manEle_G204M.getAttributeValue("resid");  //�ֹι�ȣ
                                        
                    //������ϾȵǾ������� �߰� �� seq ����
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);                    
                   
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));

                    
                	i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //������ ��� �ֹ� ��ȣ�� üũ 
                    if(i_cet_no.equals(cet_no)){
                    	
                    	gb_cd ="1";
                    
	                    if(!manEle_G204M.getAttributeValue("pre_tot_amt").equals("")) {
		                    pr_tot_amt = pr_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("pre_tot_amt"));
		                    System.out.println("2");
	                    }
	                    if(!manEle_G204M.getAttributeValue("pre_market_tot_amt").equals("")) {
		                    pr_market_tot_amt = pr_market_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("pre_market_tot_amt"));
		                    System.out.println("3");
	                    }
	                    if(!manEle_G204M.getAttributeValue("pre_tmoney_tot_amt").equals("")) {
		                    pr_tmoney_tot_amt = pr_tmoney_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("pre_tmoney_tot_amt"));
		                    System.out.println("4");
	                    }
	                    if(!manEle_G204M.getAttributeValue("ftyr_tot_amt").equals("")) {
		                    ft_tot_amt = ft_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("ftyr_tot_amt"));
		                    System.out.println("5");
	                    }
	                    if(!manEle_G204M.getAttributeValue("ftyr_market_tot_amt").equals("")) {
		                    ft_market_tot_amt = ft_market_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("ftyr_market_tot_amt"));
		                    System.out.println("6");
	                    }
	                    if(!manEle_G204M.getAttributeValue("ftyr_tmoney_tot_amt").equals("")) {
		                    ft_tmoney_tot_amt = ft_tmoney_tot_amt +Integer.parseInt(manEle_G204M.getAttributeValue("ftyr_tmoney_tot_amt"));
		                    System.out.println("7");
	                    }
                    }
                    
                    
                    for(int k=0; k<dataList_G204M.size(); k++) {
                        Element dataEle = (Element)dataList_G204M.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.�Ϲ�
                        	tot_amt = tot_amt + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //�Ϲݱ�
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.�������
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //��ݱ�
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.�߰������� ���� (�Ϲݱ�) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.���߱���
                        	tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //��ݱ�
                        	cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }
                    }
                    
                    
                    
                    drRow.setString(0, pis_yy);   //0.�ͼӳ⵵
                    drRow.setString(1, eno_no);   //1.���   
                    drRow.setString(20, form_cd);
                    drRow.setString(21, gb_cd);
                    drRow.setString(22, Integer.toString(tot_amt));
                    drRow.setString(23, Integer.toString(market_tot_amt));
                    drRow.setString(24, Integer.toString(tmoney_tot_amt));
                    drRow.setString(25, Integer.toString(cf_tot_amt));
                    drRow.setString(26, Integer.toString(cf_market_tot_amt));
                    drRow.setString(27, Integer.toString(cf_tmoney_tot_amt));
                    drRow.setString(28, Integer.toString(cs_tot_amt));
                    drRow.setString(29, Integer.toString(cs_market_tot_amt));
                    drRow.setString(30, Integer.toString(cs_tmoney_tot_amt));
                    drRow.setString(31, Integer.toString(pr_tot_amt));
                    drRow.setString(32, Integer.toString(pr_market_tot_amt));
                    drRow.setString(33, Integer.toString(pr_tmoney_tot_amt));
                    drRow.setString(34, Integer.toString(ft_tot_amt));
                    drRow.setString(35, Integer.toString(ft_market_tot_amt));
                    drRow.setString(36, Integer.toString(ft_tmoney_tot_amt));
                }
            }
            //11. ����ī�� (G303Y : �����հ�)
            else if(formEle.getAttributeValue("form_cd").equals("G303Y")) {
            	System.out.println("form_cd::"+formEle.getAttributeValue("form_cd"));
            	
            	form_cd ="����ī��";
            	
                for(int j=0; j<manList.size(); j++) {
                    name = "";
                    cet_no = "";
                    seq_no = "";
                    gb_cd ="";
                    
		        	/////////////////////////////
		            tot_amt=0;
		            market_tot_amt=0;
		            tmoney_tot_amt=0;
		            
		            cf_tot_amt=0;
		            cf_market_tot_amt=0;
		            cf_tmoney_tot_amt=0;
		            
		            cs_tot_amt=0;
		            cs_market_tot_amt=0;
		            cs_tmoney_tot_amt=0;
		            
		            pr_tot_amt=0;
		            pr_market_tot_amt=0;
		            pr_tmoney_tot_amt=0;
		                    
		            ft_tot_amt=0;
		            ft_market_tot_amt=0;
		            ft_tmoney_tot_amt=0;
		            ///////////////////////////////////
		                    
                    dir_card_amt_nts = 0;
                    market_amt_nts = 0;
                    public_amt_nts = 0;
                    last_card_amt_nts = 0;
                    last_add_card_amt_nts = 0 ;
                    add_card_amt_nts = 0;
                    pre_tot_amt = 0;
                    pre_market_tot_amt = 0;
                    pre_tmoney_tot_amt = 0; 
                    
                    Element manEle_G303Y = (Element)manList.get(j);
                    List<Element> dataList_G303Y = manEle_G303Y.getChildren();
                    
                    name    = manEle_G303Y.getAttributeValue("name");   //�̸�
                    cet_no  = manEle_G303Y.getAttributeValue("resid");  //�ֹι�ȣ
                                        
                    //������ϾȵǾ������� �߰� �� seq ����
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);                    
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));
                    
                    
                    i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //������ ��� �ֹ� ��ȣ�� üũ 
                    if(i_cet_no.equals(cet_no)){
                    	
                    	gb_cd ="1";
                    
	                    if(!manEle_G303Y.getAttributeValue("pre_tot_amt").equals("")) {
		                    pr_tot_amt = pr_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt"));
		                    System.out.println("2");
	                    }
	                    if(!manEle_G303Y.getAttributeValue("pre_market_tot_amt").equals("")) {
		                    pr_market_tot_amt = pr_market_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"));
		                    System.out.println("3");
	                    }
	                    if(!manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt").equals("")) {
		                    pr_tmoney_tot_amt = pr_tmoney_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt"));
		                    System.out.println("4");
	                    }
	                    if(!manEle_G303Y.getAttributeValue("ftyr_tot_amt").equals("")) {
		                    ft_tot_amt = ft_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("ftyr_tot_amt"));
		                    System.out.println("5");
	                    }
	                    if(!manEle_G303Y.getAttributeValue("ftyr_market_tot_amt").equals("")) {
		                    ft_market_tot_amt = ft_market_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("ftyr_market_tot_amt"));
		                    System.out.println("6");
	                    }
	                    if(!manEle_G303Y.getAttributeValue("ftyr_tmoney_tot_amt").equals("")) {
		                    ft_tmoney_tot_amt = ft_tmoney_tot_amt +Integer.parseInt(manEle_G303Y.getAttributeValue("ftyr_tmoney_tot_amt"));
		                    System.out.println("7");
	                    }
                    }
                    
                    
                    for(int k=0; k<dataList_G303Y.size(); k++) {
                        Element dataEle = (Element)dataList_G303Y.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.�Ϲ�
                        	tot_amt = tot_amt + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //�Ϲݱ�
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.�������
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //��ݱ�
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.�߰������� ���� (�Ϲݱ�) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.���߱���
                        	tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //��ݱ�
                        	cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //�Ϲݱ�
                        }
                    }
                    
                    
                    
                    drRow.setString(0, pis_yy);   //0.�ͼӳ⵵
                    drRow.setString(1, eno_no);   //1.���   
                    drRow.setString(20, form_cd);
                    drRow.setString(21, gb_cd);
                    drRow.setString(22, Integer.toString(tot_amt));
                    drRow.setString(23, Integer.toString(market_tot_amt));
                    drRow.setString(24, Integer.toString(tmoney_tot_amt));
                    drRow.setString(25, Integer.toString(cf_tot_amt));
                    drRow.setString(26, Integer.toString(cf_market_tot_amt));
                    drRow.setString(27, Integer.toString(cf_tmoney_tot_amt));
                    drRow.setString(28, Integer.toString(cs_tot_amt));
                    drRow.setString(29, Integer.toString(cs_market_tot_amt));
                    drRow.setString(30, Integer.toString(cs_tmoney_tot_amt));
                    drRow.setString(31, Integer.toString(pr_tot_amt));
                    drRow.setString(32, Integer.toString(pr_market_tot_amt));
                    drRow.setString(33, Integer.toString(pr_tmoney_tot_amt));
                    drRow.setString(34, Integer.toString(ft_tot_amt));
                    drRow.setString(35, Integer.toString(ft_market_tot_amt));
                    drRow.setString(36, Integer.toString(ft_tmoney_tot_amt));
                }
                    

                    /*
                    if(drRow.getString(16) == null) {
                        market_amt_nts = 0;
                    }else {
                        market_amt_nts = Integer.parseInt(drRow.getString(16)); //16.���������ݾ�
                    }
                    if(drRow.getString(17) == null) {
                        public_amt_nts = 0;
                    }else {
                        public_amt_nts = Integer.parseInt(drRow.getString(17)); //17.���߱�����ݾ�
                    }
                    if(drRow.getString(25) == null) {
                        last_card_amt_nts = 0;
                    }else {
                        last_card_amt_nts = Integer.parseInt(drRow.getString(25)); //25.������ �ſ�ī�� ����
                    }
                    if(drRow.getString(26) == null) {
                        last_add_card_amt_nts = 0;
                    }else {
                        last_add_card_amt_nts = Integer.parseInt(drRow.getString(26)); //26.������ �߰������� ����
                    }
                    if(drRow.getString(27) == null) {
                        add_card_amt_nts = 0;
                    }else {
                        add_card_amt_nts = Integer.parseInt(drRow.getString(27)); //27.�߰������� ����
                    }
                    
                    if(!manEle_G303Y.getAttributeValue("pre_tot_amt").equals("")) {
                        pre_tot_amt = Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt")) ;
                    }
                    if(!manEle_G303Y.getAttributeValue("pre_market_tot_amt").equals("")) {
                        pre_market_tot_amt = Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"));
                    }
                    if(!manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt").equals("")) {
                        pre_tmoney_tot_amt =Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt")) ;
                    }
                    
                    //25.������ �ſ�ī�� ����
                    last_card_amt_nts = last_card_amt_nts 
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt"))          //������_�Ϲݰ������ݾ��հ�
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"))   //������_�������������ݾ��հ�
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt"))   //������_���߱���������ݾ��հ� 
                                        + pre_tot_amt
                                        + pre_market_tot_amt
                                        + pre_tmoney_tot_amt
                                        ;
                    //26.������ �߰������� ���� (�������+���߱���+���ݿ�����+����ī��(����ī��))
                    last_add_card_amt_nts = last_add_card_amt_nts 
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt"))          //������_�Ϲݰ������ݾ��հ�
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"))  //������_�������������ݾ��հ�
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt"))  //������_���߱���������ݾ��հ� 
                                        + pre_tot_amt
                                        + pre_market_tot_amt
                                        + pre_tmoney_tot_amt
                                         ;
                    
                    for(int k=0; k<dataList_G303Y.size(); k++) {
                        Element dataEle = (Element)dataList_G303Y.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.�Ϲ�
                            dir_card_amt_nts = dir_card_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //dir_card_amt_nts = dir_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.�߰������� ���� (�Ϲݱ�) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.�������
                            market_amt_nts = market_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //market_amt_nts = market_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.�߰������� ���� (�Ϲݱ�) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.���߱���
                            public_amt_nts = public_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //public_amt_nts = public_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.�߰������� ���� (�Ϲݱ�) 
                        }
                    }
                    
                    drRow.setString(15, Integer.toString(dir_card_amt_nts)); //15.����ī����ݾ�
                    drRow.setString(16, Integer.toString(market_amt_nts));      //16.���������ݾ�
                    drRow.setString(17, Integer.toString(public_amt_nts));      //17.���߱�����ݾ�
                    drRow.setString(25, Integer.toString(last_card_amt_nts));      //25.������ �ſ�ī�� ����
                    drRow.setString(26, Integer.toString(last_add_card_amt_nts));  //26.������ �߰������� ����  
                    drRow.setString(27, Integer.toString(add_card_amt_nts));       //27.�߰������� ����
                    */ 
                
            } 
        }
        
        GauceDataSet[] rtnDS = { dsT_AC_FAMILY };     
        
        //GauceDataSet[] rtnDS = { dsT_AC_FAMILY, dsT_AC_MEDICAL, dsT_AC_PENSION, dsT_AC_DONATION, dsT_AC_INSURANCE };
        
        System.out.println("rtnDS:::dsT_AC_FAMILY::");
        return rtnDS;
    }
        
    
    /**
     * ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA099_SAV(CBox p_box, TrBox p_tr) throws CException {
        
    	System.out.println("YACA099_SAV::");
    	
        GauceValueObject voFAMILY   = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");
        GauceDataSet     dsFamilyChk = null;
        //GauceValueObject vo = null;
        //Integer          upt_fam_no = 0;

        //YACA099DAO dao = new YACA099DAO(connectionName, p_tr);  
        
        YACA099DAO dao = new YACA099DAO("default", p_tr);		
        
        System.out.println("wrk.YACA099_SAV::"+voFAMILY.size());
        
        String dsArray[][] = null;
		
		dsArray = new String[voFAMILY.size()][40];
        
        
        /* 1. �������� (T_AC_FAMILY) */
        //vo = null;
        for (int i=0; i<voFAMILY.size(); i++) {
        	
        	System.out.println("i::"+i);
        	
        	/** ValueObjectList���� ValueObject�� ������ �κ� **/
        	GauceValueObject vo = voFAMILY.get(i); // LIST -> ROW
            /**
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            
            System.out.println("i::"+i+"::TX_MODE::"+vo.getInt("TX_MODE"));
            
            if(vo.getInt("TX_MODE") == 2) {
                //dao.YACA099_INS_FAM(vo, p_box);
                System.out.println("vo::"+vo);           	
                System.out.println("p_box::"+p_box);            	
                //dao.YACA099_INS_FAM_TEST(vo, p_box);
               // dao.YACA099_INS_FAM_TEST2(vo, p_box);
                
                for (int k=0; k<voFAMILY.size(); k++) {
        			
					if(dsArray[k][0] == null && dsArray[k][1] == null && dsArray[k][2] == null&& dsArray[k][3] == null&& dsArray[k][5] == null ){
						dsArray[k][0]  = vo.get("PIS_YY") ;//
						dsArray[k][1]  = vo.get("ENO_NO") ;//				               		      			    
						dsArray[k][2]  = vo.get("PIS_YY") ;//
						dsArray[k][3]  = vo.get("ENO_NO") ;//
						dsArray[k][4]  = vo.get("NAM_KOR");//
						dsArray[k][5]  = vo.get("CET_NO") ;//
						dsArray[k][6]  = vo.get("CARD_AMT_NTS") ;//
						dsArray[k][7]  = vo.get("DIR_CARD_AMT_NTS") ;//
						dsArray[k][8]  = vo.get("CASH_AMT_NTS") ;//
						dsArray[k][9]  = vo.get("MARKET_AMT_NTS") ;//
						dsArray[k][10] = vo.get("PUBLIC_AMT_NTS") ;//
						dsArray[k][11] = vo.get("CARD_2015_FH_AMT") ;//
						dsArray[k][12] = vo.get("CARD_2015_SH_AMT") ;//
						dsArray[k][13] = vo.get("CARD_2015_AMT") ;//
						dsArray[k][14] = vo.get("CARD_2015_FH_OVER") ;//
						dsArray[k][15] = vo.get("CARD_2015_SH_OVER") ;//
						dsArray[k][16] = vo.get("CARD_2013_AMT") ;//
						dsArray[k][17] = vo.get("CARD_2014_AMT") ;//
						dsArray[k][18] = vo.get("CARD_2013_OVER") ;//
						dsArray[k][19] = vo.get("CARD_2014_OVER") ;//
						dsArray[k][20] = vo.get("FILE_SEQ") ;//
						dsArray[k][21] = vo.get("FORM_CD") ;//
						dsArray[k][22] = vo.get("GB_CD") ;//
						dsArray[k][23] = vo.get("TOT_AMT") ;//
						dsArray[k][24] = vo.get("MARKET_TOT_AMT") ;//
						dsArray[k][25] = vo.get("TMONEY_TOT_AMT") ;//
						dsArray[k][26] = vo.get("CS_TOT_AMT") ;//
						dsArray[k][27] = vo.get("CS_MARKET_TOT_AMT") ;//
						dsArray[k][28] = vo.get("CS_TMONEY_TOT_AMT") ;//
						dsArray[k][29] = vo.get("PR_TOT_AMT") ;//
						dsArray[k][30] = vo.get("PR_MARKET_TOT_AMT") ;//
						dsArray[k][31] = vo.get("PR_TMONEY_TOT_AMT") ;//
						dsArray[k][32] = vo.get("FT_TOT_AMT") ;//
						dsArray[k][33] = vo.get("FT_MARKET_TOT_AMT") ;//
						dsArray[k][34] = vo.get("FT_TMONEY_TOT_AMT") ;//
						dsArray[k][35] = vo.get("CF_TOT_AMT") ;//
						dsArray[k][36] = vo.get("CF_MARKET_TOT_AMT") ;//
						dsArray[k][37] = vo.get("CF_TMONEY_TOT_AMT") ;//
						dsArray[k][38] = vo.get("ENO_NO") ;//
						dsArray[k][39] = vo.get("ENO_NO") ;//
						break;
					}
				}
            }
            
            else if(vo.getInt("TX_MODE") == 4) {  //�����ΰ�� �ӽ����̺� ����, ��ϵ� �ξ簡�����̺��� ����û �ڷ� 0������ ����, RETACC ���̺� ����
                dao.YACA099_DEL_FAM_TEMP(vo, p_box);
                break;
            }
            System.out.println("end::"+i);
        }
        
        
      //�ٽ�  ����
		for (int i=0; i<voFAMILY.size(); i++) {
			if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][2] != null&& dsArray[i][3] != null&& dsArray[i][5] != null ){
		
				this.YACA099_INS(p_box, dsArray, i, p_tr);	
				//dao.YACA040_INS_14(p_box, dsArray, i);
			}
		}		
        
        
        //if(p_box.get("DEL_TAG").equals("D")) {
           
            /* �߰��߰� >> ����û �Ƿ��,��α�,�������� ������ ���� T_AC_FAMILY, T_AC_RETACC ���� ���� �����Ұ�*/
            //if(p_box.get("APP_YN").equals("Y")) {
                ////dao.YACA010_UPT_FAM(p_box);     
                ////YACA021WRK.YACA021_UPT_ACC( p_box,  p_tr);
            //}
            ////FILEWRK.FILE_DEL_02(p_box, p_tr);
        //}
    }
    
    
    public void YACA099_INS(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

    	/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
    	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

    	/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
    	YACA099DAO dao = new YACA099DAO("default", p_tr);

    	dao.YACA099_INS_FAM(p_box, dsArray, i);

    }		
    
    
    public void YACA099_SAV_TEST( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA099DAO dao = new YACA099DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][2];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null ){
						dsArray[k][0]  = vo.get("PIS_YY") ;//�ͼӳ⵵
						dsArray[k][1]  = vo.get("NAM_KOR") ;//�����ȣ
						
						break;
					}
				}
		}

			//�ٽ�  ����
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null ){
			
					this.YACA099_INS_TEST(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	


  public void YACA099_INS_TEST(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

	/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

	/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
	YACA099DAO dao = new YACA099DAO("default", p_tr);

	dao.YACA099_INS_FAM_TEST2(p_box, dsArray, i);

	}		

    
    
           
    /**
     * ��ȸ
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA099_SHR(CBox p_box, TrBox p_tr) throws CException {
        
        GauceDataSet   dsT_AC_FAMILY_TEMP = new GauceDataSet();
        
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        YACA099DAO dao = new YACA099DAO(connectionName, p_tr);        

        dsT_AC_FAMILY_TEMP = dao.YACA099_SHR_FAM(p_box);
       
        
        p_tr.setOutDataSet("dsT_AC_FAMILY_TEMP", dsT_AC_FAMILY_TEMP);
             
    }
    
    /**
     * �������� �ξ簡���������� �̹� ��ϵǾ����� ��ȸ
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA099_SHR_CHK(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        YACA099DAO dao = new YACA099DAO(connectionName, p_tr);        
        
        dao.YACA099_SHR_CHK(p_box);
    }
    
    
    /** seq_no return ȸ**/
    public String YACA099_SEQ_NO (GauceDataSet ds, String pis_yy, String eno_no, String nam_kor, String cet_no, String file_seq) {
        
        String  seq_no = "";
        
       
        return seq_no;
    }
    
    
    /**
     * ��ȸ
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    
    public void YACA099_FAM_UPT_SHR(CBox p_box, TrBox p_tr) throws CException {
               
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        dao = new YACA099DAO(connectionName, p_tr);        
        p_tr.setOutDataSet("dsT_AC_FAMILY_UPDATE" , dao.YACA099_FAM_UPT_SHR(p_box));     //1.�������� ������ �����ͼ� DS �� ���
             
    }
    
    public void YACA099_FAM_CARD_UPT(CBox p_box, TrBox p_tr) throws CException {
        
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
    	
    	GauceValueObject voFAMILY   = p_tr.getInGauceValueObject("dsT_AC_FAMILY_UPDATE");
        GauceDataSet     dsFamilyChk = null;
    	
        dao = new YACA099DAO(connectionName, p_tr);     
        YACA099DAO dao = new YACA099DAO("default", p_tr);		
        
        String dsArray[][] = null;
		
		dsArray = new String[voFAMILY.size()][17];
        
        //vo = null;
        for (int i=0; i<voFAMILY.size(); i++) {
        	
        	System.out.println("i::"+i);
        	
        	/** ValueObjectList���� ValueObject�� ������ �κ� **/
        	GauceValueObject vo = voFAMILY.get(i); // LIST -> ROW
            /**
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            
            System.out.println("i::"+i+"::TX_MODE::"+vo.getInt("TX_MODE"));
            if(vo.getInt("TX_MODE") == 2) {
              
                System.out.println("vo::"+vo);           	
                System.out.println("p_box::"+p_box);   
              
              
               // for (int k=0; k<voFAMILY.size(); k++) {
    				dsArray[i][0]  = vo.get("CARD_AMT_NTS") ;//
					dsArray[i][1]  = vo.get("DIR_CARD_AMT_NTS") ;//
					dsArray[i][2]  = vo.get("CASH_AMT_NTS") ;//
					dsArray[i][3]  = vo.get("MARKET_AMT_NTS") ;//
					dsArray[i][4]  = vo.get("PUBLIC_AMT_NTS") ;//
					dsArray[i][5]  = vo.get("CARD_2015_AMT") ;//
					dsArray[i][6]  = vo.get("CARD_2015_FH_AMT") ;//
					dsArray[i][7]  = vo.get("CARD_2015_SH_AMT") ;//
					dsArray[i][8]  = vo.get("CARD_2015_FH_OVER") ;//
					dsArray[i][9]  = vo.get("CARD_2015_SH_OVER") ;//
					dsArray[i][10] = vo.get("CARD_2013_AMT") ;//
					dsArray[i][11] = vo.get("CARD_2014_AMT") ;//
					dsArray[i][12] = vo.get("CARD_2013_OVER") ;//
					dsArray[i][13] = vo.get("CARD_2014_OVER") ;//
					dsArray[i][14] = vo.get("PIS_YY") ;//
					dsArray[i][15] = vo.get("ENO_NO");//
					dsArray[i][16] = vo.get("CET_NO") ;//
					
					System.out.println("CARD_AMT_NTS:"+dsArray[i][0] );
					System.out.println("DIR_CARD_AMT_NTS:"+dsArray[i][1] );
					System.out.println("CASH_AMT_NTS:"+dsArray[i][2] );
					System.out.println("MARKET_AMT_NTS:"+dsArray[i][3] );
					System.out.println("PUBLIC_AMT_NTS:"+dsArray[i][4] );
					System.out.println("CARD_2015_AMT:"+dsArray[i][5] );
					System.out.println("CARD_2015_FH_AMT:"+dsArray[i][6] );
					System.out.println("CARD_2015_SH_AMT:"+dsArray[i][7] );
					System.out.println("CARD_2015_FH_OVER:"+dsArray[i][8] );
					System.out.println("CARD_2015_SH_OVER:"+dsArray[i][9] );
					System.out.println("CARD_2013_AMT:"+dsArray[i][10] );
					System.out.println("CARD_2014_AMT:"+dsArray[i][11]);
					System.out.println("CARD_2013_OVER:"+dsArray[i][12]);
					System.out.println("CARD_2014_OVER:"+dsArray[i][13]);
					System.out.println("PIS_YY:"+dsArray[i][14]);
					System.out.println("ENO_NO:"+dsArray[i][15]);
					System.out.println("CET_NO:"+dsArray[i][16]);
					
					
					//break;
				//}
				
            }
            
            else if(vo.getInt("TX_MODE") == 4) {  //�����ΰ�� �ӽ����̺� ����, ��ϵ� �ξ簡�����̺��� ����û �ڷ� 0������ ����, RETACC ���̺� ����
                //dao.YACA099_DEL_FAM(vo, p_box);
            }
            System.out.println("end::"+i);
        }
        
        
      //�ٽ�  ����
		for (int i=0; i<voFAMILY.size(); i++) {
			
			System.out.println("i::"+i);
			this.YACA099_FAM_CARD_UPDATE(p_box, dsArray, i, p_tr);	
		}		
		
		
		//RETACC CARD�� ������Ʈ 
		 YACA099DAO dao2 = new YACA099DAO(connectionName, p_tr);        
	     dao2.YACA099_RETACC_CARD_UPT(p_box);
              
	    // 
	     
	     YACA099DAO dao3 = new YACA099DAO(connectionName, p_tr);        
	     dao3.YACA099_FAMILY_TEMP_LOCK_UPT(p_box);
    }
    
    
    public void YACA099_FAM_CARD_UPDATE(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

    	
    	System.out.println("YACA099_FAM_CARD_UPDATE::1");
    	/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
    	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_UPDATE");

    	/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
    	YACA099DAO dao = new YACA099DAO("default", p_tr);

    	dao.YACA099_FAMILY_CARD_UPT(p_box, dsArray, i);

    }		
    
    
    
    
   
    
}

