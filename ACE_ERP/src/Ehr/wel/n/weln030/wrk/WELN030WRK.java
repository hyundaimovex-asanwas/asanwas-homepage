package Ehr.wel.n.weln030.wrk;

import Ehr.wel.n.weln030.dao.WELN030DAO;

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
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class WELN030WRK {

	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void WELN030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** WELJ030DAO 객체 생성 후 관련 메소드 호출 */
		WELN030DAO dao = new WELN030DAO("default", p_tr);
		dao.WELN030_SHR(p_box);

	}


	/**
	 * 정보를 삭제하기 위한 WORK메소드 호출
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);
		WELN030DAO dao2 = new WELN030DAO("default", p_tr);
		
		dao.WELN030_DEL(p_box);
		dao2.WELN030_DEL2(p_box);


	}


    /**
     * EXCEL 파일 업로드
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void WELN030_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";

        //엑셀파일 정보를 담기 위한 데이터셋
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

        ds.addDataColumn(new GauceDataColumn("SEQID",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ENO_NM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("RESINO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("APPDT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("MEMBER",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SALAMT", GauceDataColumn.TB_STRING ));

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

                if(row.getPhysicalNumberOfCells() != 6)
                    throw new BizException("엑셀파일의 셀의 갯수는 6개이어야 합니다!");
                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setString( 1, POIUtil.getString(row, 1));
                    dr.setString( 2, POIUtil.getString(row, 2));
                    dr.setString( 3, POIUtil.getString(row, 3));
                    dr.setString( 4, POIUtil.getString(row, 4));
                    dr.setString( 5, POIUtil.getString(row, 5));

                    ds.addDataRow(dr);

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

        p_tr.setOutDataSet("dsT_WL_WELCARD", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));

    }


	/**
	 * 정보를 저장하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");
        GauceValueObject vo = null;

		WELN030DAO dao = new WELN030DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                this.WELN030_SAV(vo, p_box, p_tr);
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


	public void WELN030_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);

		dao.WELN030_SAV(vo, p_box);

	}		
	
	
	
	/**
	 * 정보를 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_SAV_01(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");
        GauceValueObject vo = null;

		WELN030DAO dao = new WELN030DAO("default", p_tr);

        dao.WELN030_SAV_01(vo, p_box);

		if(err_cnt>0){
			resultMsg = "전체 "+voList.size()+"건 중 "+err_cnt+"건의 등록이 실패하였습니다.";
		}else{
			resultMsg = "전체 "+voList.size()+"건의 등록이 성공하였습니다.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	/**
	 * 마감 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_SAV_END(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);

		dao.WELN030_SAV_END(p_box);

	}



}

