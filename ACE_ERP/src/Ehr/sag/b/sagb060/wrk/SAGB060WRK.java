package Ehr.sag.b.sagb060.wrk;

import Ehr.sag.b.sagb060.dao.SAGB060DAO;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class SAGB060WRK {

	/**
	 * 변동지불공제File 내용 조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGB060_SHR( CBox p_box, TrBox p_tr ) throws CException {

		InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        SAGB060DAO dao = new SAGB060DAO("default", p_tr);
        
        GauceValueObject voList = null;
        
        GauceValueObject vo = null;

        String resultMsg = "";


		//엑셀파일 정보를 담기 위한 데이터셋
		GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;
		ds.addDataColumn(new GauceDataColumn("ENO_NO", GauceDataColumn.TB_STRING,  8, 0, GauceDataColumn.TB_KEY));
        ds.addDataColumn(new GauceDataColumn("AMOUNT", GauceDataColumn.TB_NUMBER ));
        ds.addDataColumn(new GauceDataColumn("REMARK", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("OCC_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("DPT_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("JOB_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("PIS_YY", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("PIS_MM", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("SAL_GBN", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("SAL_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("AD_TAG", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BON_NUM", GauceDataColumn.TB_STRING ));

        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;

		try{
			
			//워크북을 생성!
            workbook = new HSSFWorkbook(new POIFSFileSystem(is));

            //시트 이름과 시트번호를 추출
        	sheet = workbook.getSheetAt(0);//첫번째 시트
        	
            row     = null;
            
        }catch(Exception e) {
        	
            Log.err.println(e.getMessage());
            
        }

        if(sheet != null) {
        	
            //HEADER 부분 건너뜀 INDEX 1부터 시작
        	
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	
                // 시트에 대한 행을 하나씩 추출
            	
                row = sheet.getRow(i);

            	if(row.getPhysicalNumberOfCells() != 5)
                    throw new BizException("엑셀파일의 셀의 갯수는 5개이어야 합니다!");

                try {
            		dr = new GauceDataRow(ds.getDataColCnt());

                    //사번정보 조회
                    voList = GauceUtils.getGauceValueObject(this.SAGB060_SHR(POIUtil.getString(row, 0),p_tr));

                    if(voList.size() != 1)
                        throw new Exception((i+1)+"번째줄 ("+POIUtil.getString(row, 0)+") 의 사번이 존재하지 않습니다.\n");

                    vo = voList.get(0);

            		dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setLong(   1, POIUtil.getLong(  row, 1));
                    dr.setString( 2, POIUtil.getString(row, 4));
            		dr.setString( 3, vo.getString("OCC_CD"));
            		dr.setString( 4, vo.getString("DPT_CD"));
            		dr.setString( 5, vo.getString("JOB_CD"));
                    dr.setString( 6, "");
                    dr.setString( 7, "");
                    dr.setString( 8, "");
                    dr.setString( 9,  POIUtil.getString(row, 2));
                    dr.setString(10, POIUtil.getString(row, 3));
                    dr.setString(11, "");


                    ds.addDataRow(dr);
                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

		p_tr.setOutDataSet("dsT_CP_CHANGE", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	
	public GauceDataSet SAGB060_SHR(String Eno_no, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_SHR(Eno_no);

	}		
	
	
	
	/**
	 * 변동지불공제File전송 저장
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGB060_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CP_CHANGE");
        GauceValueObject vo = null;
        GauceValueObject chk_worklog = null;
        GauceValueObject voT_CP_CHANGE = null;//작업번호 조회용

        int a_pro_sts = 0;

        String WRK_SEQ = "";
        String end_enono = "";
        String resultMsg = "";

		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		//첫시작일때 work log에서 급상여 처리가 끝났는지 여부를 가지고 온다.
        chk_worklog = GauceUtils.getGauceValueObject(this.SAGB060_CHK_WORKLOG(p_box, p_tr)).get(0);
        
        a_pro_sts = chk_worklog.getInt("A_PRO_STS");

        //System.out.println("a_pro_sts : " +a_pro_sts);

        //작업번호추가 - 저장시 작업번호를부여
        voT_CP_CHANGE = GauceUtils.getGauceValueObject(this.SAGB060_SHR_01(p_box, p_tr)).get(0);
        
        WRK_SEQ = voT_CP_CHANGE.get("WRK_SEQ");

        
        // 2012.12.21 이동훈 수정 이것땜에 전에 변동지불들이 다 날라갔다.
        
        //dao.SAGB060_DEL(p_box);

		for (int i=0; i<voList.size(); i++) {
			
			vo = voList.get(i);	// LIST -> ROW
			
			//System.out.print(vo);
            // 해당 work log가 종료되었거나 work log가 없는지 여부를 검증
			
            if( (vo.getString("OCC_CD").equals("A") && (a_pro_sts == 0 || a_pro_sts == 6)) ) {
            	
                end_enono += vo.get("ENO_NO")+"\n";
                
                resultMsg += (i+1)+"번째줄 ("+vo.getString("ENO_NO")+") 의 작업로그가 종료되었습니다.\n";
                
                continue;
            }

            //데이타입력중 실패한 데이타 검증
            try {
                this.SAGB060_INS(p_box, vo, p_tr, WRK_SEQ);
                
            } catch(CException e) {
            	
                resultMsg += (i+1)+"번째줄 ("+vo.getString("ENO_NO")+") 의 데이타 등록에 실패하였습니다.\n";
                
            }
            
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        
	}
	
	
	public void SAGB060_INS(CBox p_box, GauceValueObject vo, TrBox p_tr, String WRK_SEQ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		dao.SAGB060_INS(p_box, vo, WRK_SEQ);

	}		
	
	
	public GauceDataSet SAGB060_CHK_WORKLOG(CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_CHK_WORKLOG(p_box);

	}			
	
	
	public GauceDataSet SAGB060_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_SHR_01(p_box);

	}			
	
	
}




