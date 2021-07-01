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

//추가
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
     * 파일 변환
     * @param p_box
     * @throws CException
     * @throws IOException
     * @throws NumberFormatException 
     * @throws JDOMException
     */
    public void YACA099_FILE(CBox p_box, TrBox p_tr) throws CException, IOException, NumberFormatException, JDOMException {

        String xml = null;
        GauceDataSet[] rtnDS = null;
        GauceDataSet   dsRESULT = new GauceDataSet();    //파일 변환 성공 여부 리턴
        GauceDataSet   dsT_AC_FAMILY = new GauceDataSet();
        GauceDataRow   row = null;

        GauceDataColumn[] cols = {
                new GauceDataColumn("RESULT",  ColumnProp.COLUMN_TYPE_STRING)
        };
        dsRESULT.addDataColumns(cols);
        
        
        System.out.println("YACA099_FILE::CET_NO"+p_box.get("CET_NO"));
        //전자문서 파일 > xml 로 변환 (오류검증하여, 오류시 오류 문구 리턴)
        xml = getData(p_box.get("PIS_YY"), p_box.get("ENO_NO"), p_box.get("FILE_URL"),  p_box.get("CET_NO"));
        
        if(xml.substring(0,2).equals("NG")) {  //실패했을 경우 >>> 에러 메세지 전달
            row = dsRESULT.newDataRow();
            row.addColumnValue(xml);
            dsRESULT.addDataRow(row);
        }else {
            row = dsRESULT.newDataRow();
            row.addColumnValue("OK");
            dsRESULT.addDataRow(row);
            
            //xml 파싱하여 데이터셋으로 변환
            rtnDS = ConvertXml(xml, p_box.get("PIS_YY"), p_box.get("ENO_NO"), p_box.get("FILE_SEQ"),p_box.get("CET_NO"));
            
            dsT_AC_FAMILY = rtnDS[0];
        }
        
        p_tr.setOutDataSet("dsRESULT" , dsRESULT);
        p_tr.setOutDataSet("dsT_AC_FAMILY_FILE" , dsT_AC_FAMILY);
        
    }
    
    /** 입력받은 PDF 형식의 전자문서 XML 형태로 변환 
     * 20151208 2015년귀속분 수정
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
        String rtnXml      = null; //결과 xml
        String p_pwd       = null; //암호화된 파일을 위한 비밀번호. 추후 입력받은 파라메타 값 넘기기 or 주민번호로 자동 셋팅
        String errorMsg    = null; //리턴할 에러메시지
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
            errorMsg = "PDF문서가 아니거나 손상된 문서입니다.";
            rtnXml = "실패";
        }
        
        /* [Step1] 전자문서 위변조 검증 */
        try {
        	
        	System.out.println("[Step1] 전자문서 위변조 검증");
        	
            DSTSPDFSig dstsPdfsig = new DSTSPDFSig();
            
            dstsPdfsig.init(fileByte);
            dstsPdfsig.tokenParse();

            isSuccess = dstsPdfsig.tokenVerify();
            
            if( isSuccess ) {
                System.out.println("<!-- 검증 완료(진본) -->");
            } else {
                String msg = dstsPdfsig.getTstVerifyFailInfo();
                System.out.println(msg);
                errorMsg = msg;
                rtnXml = "실패";
            }
        } catch (DVException e) {
            System.out.println("에러 코드 : "+ e.getLastError());
            System.out.println("에러 메시지 : "+ e.getMessage());
            
            errorMsg = "에러 코드 : "+ e.getLastError()+"  에러 메시지 : "+ e.getMessage();
            rtnXml = "실패";
        }
        
        /* [Step2] XML(or SAM) 데이터 추출 */

        try {
        	
        	System.out.println("[Step2] XML(or SAM) 데이터 추출 ");
            if (isSuccess) {
                ExportCustomFile pdf = new ExportCustomFile();
                
                System.out.println("fileByte:" +fileByte);
                System.out.println("p_pwd:"+p_pwd);
                System.out.println("key:"+key);
                System.out.println("---------------------");
    
                // 데이터 추출
                //로컬용
                //byte[] buf = pdf.NTS_GetFileBufEx(fileByte, p_pwd, key, true );
                
                //서버용
                byte[] buf = pdf.NTS_GetFileBufEx(fileByte, p_pwd, key, false );
                int v_ret = pdf.NTS_GetLastError();
                
                
                System.out.println("v_ret:: "+v_ret);
    
                if (v_ret == 1||v_ret==-2) {
                	//로컬용
                    //String strXml = new String( buf, "EUC-KR" );
                	//서버용
                    String strXml = new String( buf, "UTF-8" );
                    // 정상적으로 추출된 데이터 활용하는 로직 구현 부분
                    System.out.print(strXml);   // 예제에서는 화면에 출력
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
                    
                    //전자문서 확인
                    if(!docEle.getChildTextTrim("doc_type").equals("A")&&!docEle.getChildTextTrim("doc_type").equals("B")&&!docEle.getChildTextTrim("doc_type").equals("D")) {  //B.기본내역 D.상세내역
                        rtnXml = "NG : 기본내역을 등록하세요.";
                    }else if(!docEle.getChildTextTrim("att_year").equals(pis_yy)) {     //귀속연도
                        rtnXml = "NG  : 귀속연도의 자료를 등록하세요.";
                    }
                    
                } else if (v_ret == 0) {
                    System.out.println("연말정산간소화 표준 전자문서가 아닙니다.");
                    errorMsg = "연말정산간소화 표준 전자문서가 아닙니다.";
                    rtnXml = "실패";
                } else if (v_ret == -1) {
                    System.out.println("비밀번호가 틀립니다.");
                    errorMsg = "비밀번호가 틀립니다.";
                    rtnXml = "실패";
                } else if (v_ret == -2) {
                    System.out.println("PDF문서가 아니거나 손상된 문서입니다.");
                    errorMsg = "PDF문서가 아니거나 손상된 문서입니다.";
                    rtnXml = "실패";
                } else {
                    System.out.println("데이터 추출에 실패하였습니다.");
                    errorMsg = "데이터 추출에 실패하였습니다.";
                    rtnXml = "실패";
                }
            }
            
        } catch (Exception e) {
            System.out.println("[Step2] 데이터 추출 실패(" + e.toString() + ")");
            errorMsg = "[Step2] 데이터 추출 실패(" + e.toString() + ")";
            rtnXml = "실패";
        }
        
        if(rtnXml == "실패") {
            rtnXml = "NG "+rtnXml +" : "+ errorMsg;
        }
        
        return rtnXml;
    }
      
    /** FAMILY 데이터셋 검색하며 해당 가족 등록되어있는지 조회 **
     *  등록되어있으면   >>> 등록된 row(SEQ) 리턴
     *  등록안되어있으면 >>> 등록 후, row(SEQ) 리턴            **/
    public String FamilySearch(GauceDataSet ds, String pis_yy, String eno_no, String nam_kor, String cet_no, String file_seq) {
        
        String  seq_no = "";
        int     r_yn   = -1;
        GauceDataRow   drFAMILY      = new GauceDataRow(ds.getDataColCnt());
        GauceDataRow   drRow         = new GauceDataRow(ds.getDataColCnt());
        
        System.out.println("FamilySearch:ds.getDataRowCnt():"+ds.getDataRowCnt());
        
        for(int r=0; r<ds.getDataRowCnt(); r++) {
            drRow = ds.getDataRow(r);
            System.out.println("r::"+r+"::cet_no::::"+cet_no);
            
            if(drRow.getString(3).equals(cet_no)) {  //데이터 row의 3번째 항목이 주민번호
            	
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
            
            drFAMILY.setString(0, pis_yy);      //해당년도 p_box.get("PIS_YY")
            drFAMILY.setString(1, eno_no);      //사번
            drFAMILY.setString(2, nam_kor);     //이름
            drFAMILY.setString(3, cet_no);      //주민번호
            drFAMILY.setString(4, seq_no);      //일련번호
            drFAMILY.setString(19, file_seq);   //FILE_SEQ
            
            ds.addDataRow(drFAMILY);
        }
        
        return seq_no;
    }
    
    /** xml 파싱 
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
        
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PIS_YY",             GauceDataColumn.TB_STRING ));//0.해당년도
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ENO_NO",             GauceDataColumn.TB_STRING ));//1.사번
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("NAM_KOR",            GauceDataColumn.TB_STRING ));//2.이름
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CET_NO",             GauceDataColumn.TB_STRING ));//3.주민번호
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("SEQ_NO",             GauceDataColumn.TB_STRING ));//4.일련번호
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_AMT_NTS",       GauceDataColumn.TB_STRING ));//5.신용카드사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("DIR_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//6.직불카드사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CASH_AMT_NTS",       GauceDataColumn.TB_STRING ));//7.현금영수증
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("MARKET_AMT_NTS",     GauceDataColumn.TB_STRING ));//8.전통시장사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PUBLIC_AMT_NTS",     GauceDataColumn.TB_STRING ));//9.대중교통사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_FH_AMT",   GauceDataColumn.TB_STRING ));//10.본인 2015상반기 신용카드등 사용액 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_SH_AMT",   GauceDataColumn.TB_STRING ));//11.본인 2015하반기 신용카드등 사용액 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_AMT",      GauceDataColumn.TB_STRING ));//12.본인 2015 신용카드등 사용액 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_FH_OVER",  GauceDataColumn.TB_STRING ));//13.본인 2015상반기 추가공제율사용액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2015_SH_OVER",  GauceDataColumn.TB_STRING ));//14.본인 2015하반기 추가공제율사용액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2013_AMT",      GauceDataColumn.TB_STRING ));//15.본인 2013 신용카드등 사용액 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2014_AMT",      GauceDataColumn.TB_STRING ));//16.본인 2014 신용카드등 사용액 
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2013_OVER",     GauceDataColumn.TB_STRING ));//17.본인 2013 추가공제율사용액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_2014_OVER",     GauceDataColumn.TB_STRING ));//18.본인 2014추가공제율사용액
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
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("PIS_YY",   GauceDataColumn.TB_STRING ));//0.해당년도
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ENO_NO",   GauceDataColumn.TB_STRING ));//1.사번
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("NAM_KOR",  GauceDataColumn.TB_STRING ));//2.이름
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CET_NO",   GauceDataColumn.TB_STRING ));//3.주민번호
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("SEQ_NO",   GauceDataColumn.TB_STRING ));//4.일련번호
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LIN_AMT_NTS",   GauceDataColumn.TB_STRING ));//5.보험료
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LIH_AMT_NTS",   GauceDataColumn.TB_STRING ));//6.장애인보험료
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("MED_AMT_NTS",   GauceDataColumn.TB_STRING ));//7.의료비
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LEN_AMT_NTS",   GauceDataColumn.TB_STRING ));//8.시력보정용의료비
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("EDU_TAG_NTS",   GauceDataColumn.TB_STRING ));//9.교육비구분
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("EDU_AMT_NTS",   GauceDataColumn.TB_STRING ));//10.교육비
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("HED_AMT_NTS",   GauceDataColumn.TB_STRING ));//11.장애인특수교육비
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("UNF_AMT_NTS",   GauceDataColumn.TB_STRING ));//12.교복비
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CARD_AMT_NTS",  GauceDataColumn.TB_STRING ));//13.신용카드사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("CASH_AMT_NTS",  GauceDataColumn.TB_STRING ));//14.현금영수증
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("DIR_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//15.직불카드사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("market_amt_nts",   GauceDataColumn.TB_STRING ));//16.전통시장사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("public_amt_nts",   GauceDataColumn.TB_STRING ));//17.대중교통사용금액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH1_AMT_NTS",   GauceDataColumn.TB_STRING ));//18.주택임차차입금 원리금상환액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHO_AMT_NTS",   GauceDataColumn.TB_STRING ));//19.주택마련저축 (청약저축)
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHP_AMT_NTS",   GauceDataColumn.TB_STRING ));//20.주택청약종합저축
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHR_AMT_NTS",   GauceDataColumn.TB_STRING ));//21.근로자주택마련저축
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LHM_AMT_NTS",   GauceDataColumn.TB_STRING ));//22.목돈 안드는 전세 이자상환액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LC3_AMT_NTS",   GauceDataColumn.TB_STRING ));//23.법정기부금
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LC2_AMT_NTS",   GauceDataColumn.TB_STRING ));//24.지정기부금
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LAST_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//25.직전년 신용카드 사용액
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LAST_ADD_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//26.직전년 추가공제율 사용분
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("ADD_CARD_AMT_NTS",   GauceDataColumn.TB_STRING ));//27.추가공제율 사용분
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH2_AMT04_NTS",   GauceDataColumn.TB_STRING ));//28.장기주택저당차입금 이자상환액 (2011년이전) 10~15년
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH2_AMT_NTS",   GauceDataColumn.TB_STRING ));//29.장기주택저당차입금 이자상환액 (2011년이전) 15~30년
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH4_AMT_NTS",   GauceDataColumn.TB_STRING ));//30.장기주택저당차입금 이자상환액 (2011년이전) 30년이상
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH7_AMT_NTS",   GauceDataColumn.TB_STRING ));//31.장기주택저당차입금 이자상환액 (2012년이후) 고정금리 비거치
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("LH8_AMT_NTS",   GauceDataColumn.TB_STRING ));//32.장기주택저당차입금 이자상환액 (2012년이후) 기타
        dsT_AC_FAMILY.addDataColumn(new GauceDataColumn("FILE_SEQ",      GauceDataColumn.TB_STRING ));//33.FILE_SEQ
        */
         
        GauceDataRow drRow = new GauceDataRow(dsT_AC_FAMILY.getDataColCnt());
                
        int mm      = 0; 
        int pen_row = 1;
        
        String seq_no = ""; //일련번호
        String name   = ""; //이름
        String cet_no = ""; //주민번호
        
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
        
        
        
        
        
        int card_amt_nts     = 0; //신용카드사용금
        int cash_amt_nts     = 0; //현금영수증
        int dir_card_amt_nts = 0; //직불카드사용금
        int market_amt_nts      = 0; //전통시장사용금
        int public_amt_nts   = 0; //대중교통이용금
        
        
        int card_2015_fh_amt = 0;  //본인 2015상반기 신용카드등 사용액 
        int card_2015_sh_amt = 0;  //본인 2015하반기 신용카드등 사용액 
        int card_2015_amt = 0;     //본인 2015 신용카드등 사용액       
        int card_2015_fh_over = 0; //본인 2015상반기 추가공제율사용액  	
        int card_2015_sh_over = 0; //본인 2015하반기 추가공제율사용액  	
        int card_2013_amt = 0;     //본인 2013 신용카드등 사용액       	
        int card_2014_amt = 0;     //본인 2014 신용카드등 사용액           
        int card_2013_over = 0;    //본인 2013 추가공제율사용액        
        int card_2014_over = 0;    //본인 2014추가공제율사용액   
        
        
        int first_year_tot_amt =0;  //상반기 대상금액 합계
        int second_year_tot_amt =0; //하반기 대상금액 합계
                
        //삭제
        int last_card_amt_nts   = 0; //직전년 신용카드 사용분
        int last_add_card_amt_nts = 0; //직전년 신용카드 추가공제율 사용분
        int add_card_amt_nts    = 0; //신용카드 추가공제율 사용분
        //추가 해야함.
        
        
        int ftyr_tot_amt        = 0;  //전전년도 일반공제대상금액 (2013)
        int ftyr_market_tot_amt = 0;  //전전년도 전통시장공제대상금액 (2013)
        int ftyr_tmoney_tot_amt = 0;  //전전년도 대중교통공제대상금액 (2013)
        
        
        int pre_tot_amt        = 0;  //직전년도 일반공제대상금액 (2014)
        int pre_market_tot_amt = 0;  //직전년도 전통시장공제대상금액 (2014)
        int pre_tmoney_tot_amt = 0;  //직전년도 대중교통공제대상금액 (2014)
        
        
        
        
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
           
            
        
           //9. 신용카드 (G103Y : 연간합계)
            if(formEle.getAttributeValue("form_cd").equals("G103Y")) {
            	form_cd ="신용카드";
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
                    
                    
                    ftyr_tot_amt        = 0;  //전전년도 일반공제대상금액 (2013)
                    ftyr_market_tot_amt = 0;  //전전년도 전통시장공제대상금액 (2013)
                    ftyr_tmoney_tot_amt = 0;  //전전년도 대중교통공제대상금액 (2013)
                    
                    
                    pre_tot_amt = 0;
                    pre_market_tot_amt = 0;
                    pre_tmoney_tot_amt = 0;
                    
                    Element manEle_G103Y = (Element)manList.get(j);
                    List<Element> dataList_G103Y = manEle_G103Y.getChildren();
                    
                    name    = manEle_G103Y.getAttributeValue("name");   //이름
                    cet_no  = manEle_G103Y.getAttributeValue("resid");  //주민번호
                    
                    //System.out.println("name::"+name+":cet_no:"+cet_no+"::::"+manEle_G103Y.getAttributeValue("pre_tot_amt"));
                    
                    
                    //추가
                   
                    i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //본인일 경우 주민 번호로 체크 
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
                    
                                        
                    //가족등록안되어있으면 추가 후 seq 리턴
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);
                    
                    System.out.println("seq_no::"+seq_no);
                    
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));
                    
                    System.out.println("step1");
                    
                    /*
                    if(drRow.getString(8) == null) {
                        market_amt_nts = 0;
                    }else {
                        market_amt_nts = Integer.parseInt(drRow.getString(8)); //8.전통시장사용금액
                    }
                    
                    System.out.println("step2");
                    if(drRow.getString(9) == null) {
                        public_amt_nts = 0;
                    }else {
                        public_amt_nts = Integer.parseInt(drRow.getString(9)); //9.대중교통사용금액
                    }
                    System.out.println("step3");
                    */
                  
                    System.out.println("step8");
                    
                    //업로드 데이터에서 가져오는 부분
                    for(int k=0; k<dataList_G103Y.size(); k++) {
                        Element dataEle = (Element)dataList_G103Y.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.일반
                        	tot_amt = tot_amt +  Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //하반기
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.전통시장
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //상반기
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.대중교통
                        	 tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	 cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //상반기
                        	 cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }
                    }
                    
                    System.out.println("step9"+pis_yy+"::"+eno_no);
                    
                    
                    drRow.setString(0, pis_yy);   //0.귀속년도
                    drRow.setString(1, eno_no);   //1.사번   
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
                                  
                    //drRow.setString(16, Integer.toString(card_2014_amt));     //16.2014 직전년 신용카드 사용액
                    //drRow.setString(18, Integer.toString(card_2014_over));    //18.2014직전년 추가공제율 사용분  
                    
                    
                    //drRow.setString(25, Integer.toString(last_card_amt_nts));      //25.직전년 신용카드 사용액
                    //drRow.setString(26, Integer.toString(last_add_card_amt_nts));  //26.직전년 추가공제율 사용분  
                    //drRow.setString(27, Integer.toString(add_card_amt_nts));       //27.추가공제율 사용분
                    
                    System.out.println("end");
                }
            }
            
           //10. 현금영수증 (G204M : 월별)
            else if(formEle.getAttributeValue("form_cd").equals("G204M")) {
            	
            	System.out.println("form_cd::"+formEle.getAttributeValue("form_cd"));
            	
            	form_cd ="현금영수증";
            	
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
                    
                    name    = manEle_G204M.getAttributeValue("name");   //이름
                    cet_no  = manEle_G204M.getAttributeValue("resid");  //주민번호
                                        
                    //가족등록안되어있으면 추가 후 seq 리턴
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);                    
                   
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));

                    
                	i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //본인일 경우 주민 번호로 체크 
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
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.일반
                        	tot_amt = tot_amt + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //하반기
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.전통시장
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //상반기
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.추가공제율 사용분 (하반기) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.대중교통
                        	tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //상반기
                        	cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }
                    }
                    
                    
                    
                    drRow.setString(0, pis_yy);   //0.귀속년도
                    drRow.setString(1, eno_no);   //1.사번   
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
            //11. 직불카드 (G303Y : 연간합계)
            else if(formEle.getAttributeValue("form_cd").equals("G303Y")) {
            	System.out.println("form_cd::"+formEle.getAttributeValue("form_cd"));
            	
            	form_cd ="직불카드";
            	
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
                    
                    name    = manEle_G303Y.getAttributeValue("name");   //이름
                    cet_no  = manEle_G303Y.getAttributeValue("resid");  //주민번호
                                        
                    //가족등록안되어있으면 추가 후 seq 리턴
                    seq_no = FamilySearch(dsT_AC_FAMILY, pis_yy, eno_no, name, cet_no, file_seq);                    
                    drRow = dsT_AC_FAMILY.getDataRow(Integer.parseInt(seq_no));
                    
                    
                    i_cet_no = i_cet_no.replaceAll("-", "");
                    
                    System.out.println("i_cet_no::"+i_cet_no);
                    
                    //본인일 경우 주민 번호로 체크 
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
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.일반
                        	tot_amt = tot_amt + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tot_amt = cf_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //하반기
                        	cs_tot_amt = cs_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.전통시장
                        	market_tot_amt=market_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_market_tot_amt = cf_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt")); //상반기
                        	cs_market_tot_amt = cs_market_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.추가공제율 사용분 (하반기) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.대중교통
                        	tmoney_tot_amt =  tmoney_tot_amt+Integer.parseInt(dataEle.getChildTextTrim("sum"));
                        	cf_tmoney_tot_amt=cf_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("first_year_tot_amt"));   //상반기
                        	cs_tmoney_tot_amt = cs_tmoney_tot_amt+Integer.parseInt(dataEle.getAttributeValue("second_year_tot_amt")); //하반기
                        }
                    }
                    
                    
                    
                    drRow.setString(0, pis_yy);   //0.귀속년도
                    drRow.setString(1, eno_no);   //1.사번   
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
                        market_amt_nts = Integer.parseInt(drRow.getString(16)); //16.전통시장사용금액
                    }
                    if(drRow.getString(17) == null) {
                        public_amt_nts = 0;
                    }else {
                        public_amt_nts = Integer.parseInt(drRow.getString(17)); //17.대중교통사용금액
                    }
                    if(drRow.getString(25) == null) {
                        last_card_amt_nts = 0;
                    }else {
                        last_card_amt_nts = Integer.parseInt(drRow.getString(25)); //25.직전년 신용카드 사용액
                    }
                    if(drRow.getString(26) == null) {
                        last_add_card_amt_nts = 0;
                    }else {
                        last_add_card_amt_nts = Integer.parseInt(drRow.getString(26)); //26.직전년 추가공제율 사용분
                    }
                    if(drRow.getString(27) == null) {
                        add_card_amt_nts = 0;
                    }else {
                        add_card_amt_nts = Integer.parseInt(drRow.getString(27)); //27.추가공제율 사용분
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
                    
                    //25.직전년 신용카드 사용액
                    last_card_amt_nts = last_card_amt_nts 
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt"))          //직전년_일반공제대상금액합계
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"))   //직전년_전통시장공제대상금액합계
                                        //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt"))   //직전년_대중교통공제대상금액합계 
                                        + pre_tot_amt
                                        + pre_market_tot_amt
                                        + pre_tmoney_tot_amt
                                        ;
                    //26.직전년 추가공제율 사용분 (전통시장+대중교통+현금영수증+직불카드(선불카드))
                    last_add_card_amt_nts = last_add_card_amt_nts 
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tot_amt"))          //직전년_일반공제대상금액합계
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_market_tot_amt"))  //직전년_전통시장공제대상금액합계
                                          //+ Integer.parseInt(manEle_G303Y.getAttributeValue("pre_tmoney_tot_amt"))  //직전년_대중교통공제대상금액합계 
                                        + pre_tot_amt
                                        + pre_market_tot_amt
                                        + pre_tmoney_tot_amt
                                         ;
                    
                    for(int k=0; k<dataList_G303Y.size(); k++) {
                        Element dataEle = (Element)dataList_G303Y.get(k);
                        
                        if(dataEle.getAttributeValue("use_place_cd").equals("1")) {         //1.일반
                            dir_card_amt_nts = dir_card_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //dir_card_amt_nts = dir_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.추가공제율 사용분 (하반기) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("2")) {   //2.전통시장
                            market_amt_nts = market_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //market_amt_nts = market_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.추가공제율 사용분 (하반기) 
                        }else if(dataEle.getAttributeValue("use_place_cd").equals("3")) {   //3.대중교통
                            public_amt_nts = public_amt_nts + Integer.parseInt(dataEle.getChildTextTrim("sum"));
                            //public_amt_nts = public_amt_nts + Integer.parseInt(dataEle.getAttributeValue("first_tot_amt")) + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));
                            add_card_amt_nts = add_card_amt_nts + Integer.parseInt(dataEle.getAttributeValue("second_tot_amt"));  //27.추가공제율 사용분 (하반기) 
                        }
                    }
                    
                    drRow.setString(15, Integer.toString(dir_card_amt_nts)); //15.직불카드사용금액
                    drRow.setString(16, Integer.toString(market_amt_nts));      //16.전통시장사용금액
                    drRow.setString(17, Integer.toString(public_amt_nts));      //17.대중교통사용금액
                    drRow.setString(25, Integer.toString(last_card_amt_nts));      //25.직전년 신용카드 사용액
                    drRow.setString(26, Integer.toString(last_add_card_amt_nts));  //26.직전년 추가공제율 사용분  
                    drRow.setString(27, Integer.toString(add_card_amt_nts));       //27.추가공제율 사용분
                    */ 
                
            } 
        }
        
        GauceDataSet[] rtnDS = { dsT_AC_FAMILY };     
        
        //GauceDataSet[] rtnDS = { dsT_AC_FAMILY, dsT_AC_MEDICAL, dsT_AC_PENSION, dsT_AC_DONATION, dsT_AC_INSURANCE };
        
        System.out.println("rtnDS:::dsT_AC_FAMILY::");
        return rtnDS;
    }
        
    
    /**
     * 저장
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
        
        
        /* 1. 가족사항 (T_AC_FAMILY) */
        //vo = null;
        for (int i=0; i<voFAMILY.size(); i++) {
        	
        	System.out.println("i::"+i);
        	
        	/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
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
            
            else if(vo.getInt("TX_MODE") == 4) {  //삭제인경우 임시테이블 삭제, 등록된 부양가족테이블에서 국세청 자료 0원으로 수정, RETACC 테이블 수정
                dao.YACA099_DEL_FAM_TEMP(vo, p_box);
                break;
            }
            System.out.println("end::"+i);
        }
        
        
      //다시  저장
		for (int i=0; i<voFAMILY.size(); i++) {
			if(dsArray[i][0] != null && dsArray[i][1] != null && dsArray[i][2] != null&& dsArray[i][3] != null&& dsArray[i][5] != null ){
		
				this.YACA099_INS(p_box, dsArray, i, p_tr);	
				//dao.YACA040_INS_14(p_box, dsArray, i);
			}
		}		
        
        
        //if(p_box.get("DEL_TAG").equals("D")) {
           
            /* 추가추가 >> 국세청 의료비,기부금,연금저축 삭제에 따른 T_AC_FAMILY, T_AC_RETACC 수정 로직 구현할것*/
            //if(p_box.get("APP_YN").equals("Y")) {
                ////dao.YACA010_UPT_FAM(p_box);     
                ////YACA021WRK.YACA021_UPT_ACC( p_box,  p_tr);
            //}
            ////FILEWRK.FILE_DEL_02(p_box, p_tr);
        //}
    }
    
    
    public void YACA099_INS(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

    	/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
    	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

    	/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
    	YACA099DAO dao = new YACA099DAO("default", p_tr);

    	dao.YACA099_INS_FAM(p_box, dsArray, i);

    }		
    
    
    public void YACA099_SAV_TEST( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		YACA099DAO dao = new YACA099DAO("default", p_tr);		

		String dsArray[][] = null;
		
		dsArray = new String[voList.size()][2];
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

				for (int k=0; k<voList.size(); k++) {
			
					if(dsArray[k][0] == null && dsArray[k][1] == null ){
						dsArray[k][0]  = vo.get("PIS_YY") ;//귀속년도
						dsArray[k][1]  = vo.get("NAM_KOR") ;//사원번호
						
						break;
					}
				}
		}

			//다시  저장
			for (int i=0; i<voList.size(); i++) {
				if(dsArray[i][0] != null && dsArray[i][1] != null ){
			
					this.YACA099_INS_TEST(p_box, dsArray, i, p_tr);	
					//dao.YACA040_INS_14(p_box, dsArray, i);
				}
			}			
	
	}	


  public void YACA099_INS_TEST(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

	/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_TEMP");

	/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
	YACA099DAO dao = new YACA099DAO("default", p_tr);

	dao.YACA099_INS_FAM_TEST2(p_box, dsArray, i);

	}		

    
    
           
    /**
     * 조회
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA099_SHR(CBox p_box, TrBox p_tr) throws CException {
        
        GauceDataSet   dsT_AC_FAMILY_TEMP = new GauceDataSet();
        
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        YACA099DAO dao = new YACA099DAO(connectionName, p_tr);        

        dsT_AC_FAMILY_TEMP = dao.YACA099_SHR_FAM(p_box);
       
        
        p_tr.setOutDataSet("dsT_AC_FAMILY_TEMP", dsT_AC_FAMILY_TEMP);
             
    }
    
    /**
     * 연말정산 부양가족사항으로 이미 등록되었는지 조회
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA099_SHR_CHK(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        YACA099DAO dao = new YACA099DAO(connectionName, p_tr);        
        
        dao.YACA099_SHR_CHK(p_box);
    }
    
    
    /** seq_no return 회**/
    public String YACA099_SEQ_NO (GauceDataSet ds, String pis_yy, String eno_no, String nam_kor, String cet_no, String file_seq) {
        
        String  seq_no = "";
        
       
        return seq_no;
    }
    
    
    /**
     * 조회
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    
    public void YACA099_FAM_UPT_SHR(CBox p_box, TrBox p_tr) throws CException {
               
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        dao = new YACA099DAO(connectionName, p_tr);        
        p_tr.setOutDataSet("dsT_AC_FAMILY_UPDATE" , dao.YACA099_FAM_UPT_SHR(p_box));     //1.연말정산 내역을 가져와서 DS 에 담기
             
    }
    
    public void YACA099_FAM_CARD_UPT(CBox p_box, TrBox p_tr) throws CException {
        
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
    	
    	GauceValueObject voFAMILY   = p_tr.getInGauceValueObject("dsT_AC_FAMILY_UPDATE");
        GauceDataSet     dsFamilyChk = null;
    	
        dao = new YACA099DAO(connectionName, p_tr);     
        YACA099DAO dao = new YACA099DAO("default", p_tr);		
        
        String dsArray[][] = null;
		
		dsArray = new String[voFAMILY.size()][17];
        
        //vo = null;
        for (int i=0; i<voFAMILY.size(); i++) {
        	
        	System.out.println("i::"+i);
        	
        	/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
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
            
            else if(vo.getInt("TX_MODE") == 4) {  //삭제인경우 임시테이블 삭제, 등록된 부양가족테이블에서 국세청 자료 0원으로 수정, RETACC 테이블 수정
                //dao.YACA099_DEL_FAM(vo, p_box);
            }
            System.out.println("end::"+i);
        }
        
        
      //다시  저장
		for (int i=0; i<voFAMILY.size(); i++) {
			
			System.out.println("i::"+i);
			this.YACA099_FAM_CARD_UPDATE(p_box, dsArray, i, p_tr);	
		}		
		
		
		//RETACC CARD값 업데이트 
		 YACA099DAO dao2 = new YACA099DAO(connectionName, p_tr);        
	     dao2.YACA099_RETACC_CARD_UPT(p_box);
              
	    // 
	     
	     YACA099DAO dao3 = new YACA099DAO(connectionName, p_tr);        
	     dao3.YACA099_FAMILY_TEMP_LOCK_UPT(p_box);
    }
    
    
    public void YACA099_FAM_CARD_UPDATE(CBox p_box, String[][] dsArray, int i, TrBox p_tr) throws CException {

    	
    	System.out.println("YACA099_FAM_CARD_UPDATE::1");
    	/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
    	GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY_UPDATE");

    	/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
    	YACA099DAO dao = new YACA099DAO("default", p_tr);

    	dao.YACA099_FAMILY_CARD_UPT(p_box, dsArray, i);

    }		
    
    
    
    
   
    
}

