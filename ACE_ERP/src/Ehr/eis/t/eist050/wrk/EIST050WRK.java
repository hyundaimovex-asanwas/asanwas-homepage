package Ehr.eis.t.eist050.wrk;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;
import Ehr.eis.t.eist010.dao.EIST010DAO;
import Ehr.eis.t.eist050.dao.EIST050DAO;
import Ehr.sag.d.sagd030.dao.SAGD030DAO;
import Ehr.wel.n.weln030.dao.WELN030DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST050WRK {
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST050DAO 객체 생성 후 관련 메소드 호출 */
		EIST050DAO dao = new EIST050DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST050_SHR(p_box);

	}
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST050_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST050DAO 객체 생성 후 관련 메소드 호출 */
		EIST050DAO dao = new EIST050DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST050_SHR_TEAM(p_box);

	}
	
	
	
	
	/**
	 * 정보를 저장하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_LABORCOST");
        GauceValueObject vo = null;

        EIST050DAO dao = new EIST050DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                this.EIST050_SAV(vo, p_box, p_tr);
            } catch(CException e) {
                err_cnt++;
            }
		}

		if(err_cnt>0){
			resultMsg = "전체 "+voList.size()+"건 중 "+err_cnt+"건의 등록이 실패하였습니다.";
		}else{
			resultMsg = "전체 "+voList.size()+"건의 등록이 성공하였습니다.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}	
	
	public void EIST050_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_SAV(vo, p_box);

	}		
		
	
	
	
	/**
	 * 인건비 계산 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		


		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//프로시져 인건비 계산
		dao.EIST050_INS_01(vo, p_box);


		
		
	}

	
	
	
	public void EIST050_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_INS_01(vo, p_box);

	}		
	
	
	
	
	public void EIST050_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		//System.out.println("vo1========="+vo);
		
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_UPT(vo, p_box);

	}			
	
	
	

    /**
     * EXCEL 파일 업로드
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void EIST050_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";

        //엑셀파일 정보를 담기 위한 데이터셋
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

        ds.addDataColumn(new GauceDataColumn("ENO_NO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SAL_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("RET_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("INS_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("LUN_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("WEL_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("O7_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BUS_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PARK_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("OIL_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SUM_AMT", GauceDataColumn.TB_STRING ));
        
        
        

        
        
        
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

                if(row.getPhysicalNumberOfCells() != 10)
                    throw new BizException("엑셀파일의 셀의 갯수는 10개이어야 합니다!");
                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setString( 1, POIUtil.getString(row, 1));
                    dr.setString( 2, POIUtil.getString(row, 2));
                    dr.setString( 3, POIUtil.getString(row, 3));
                    dr.setString( 4, POIUtil.getString(row, 4));
                    dr.setString( 5, POIUtil.getString(row, 5));
                    dr.setString( 6, POIUtil.getString(row, 6));
                    dr.setString( 7, POIUtil.getString(row, 7));
                    dr.setString( 8, POIUtil.getString(row, 8));
                    dr.setString( 9, POIUtil.getString(row, 9));
                    
                    ds.addDataRow(dr);

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

        p_tr.setOutDataSet("dsT_TS_LABORCOST", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));

    }

	
	
	
	
	
	
	/**
	 * 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_LABORCOST");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_DEL(p_box);

	}
	
	
}

