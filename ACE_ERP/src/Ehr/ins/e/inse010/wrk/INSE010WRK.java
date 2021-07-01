package Ehr.ins.e.inse010.wrk;


import Ehr.ins.e.inse010.dao.INSE010DAO;

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
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class INSE010WRK {




	/**
	 * 보증보험료 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void INSE010_SHR(CBox p_box, TrBox p_tr) throws CException {

		INSE010DAO dao = new INSE010DAO("default", p_tr);
		dao.INSE010_SHR(p_box);
	}



    /**
     * EXCEL 파일 업로드
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSE010_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";


        //엑셀파일 정보를 담기 위한 데이터셋
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;
        ds.addDataColumn(new GauceDataColumn("ENO_NM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ENO_NO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("INSU_AMT", GauceDataColumn.TB_STRING ));

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

                if(row.getPhysicalNumberOfCells() != 3)
                    throw new BizException("엑셀파일의 셀의 갯수는 3개이어야 합니다!");

                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setString( 1, POIUtil.getString(row, 1));
                    dr.setString( 2, POIUtil.getString(row, 2));

                    ds.addDataRow(dr);
                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }


        p_tr.setOutDataSet("dsT_CM_PERSON", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
    }

	/**
	 * 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void INSE010_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_PERSON");
        GauceValueObject vo = null;

		INSE010DAO dao = new INSE010DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                dao.INSE010_UPT(vo, p_box);
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
}

