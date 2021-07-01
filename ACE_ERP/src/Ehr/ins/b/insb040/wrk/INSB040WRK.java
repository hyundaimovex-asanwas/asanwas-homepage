package Ehr.ins.b.insb040.wrk;

import Ehr.ins.b.insb040.dao.INSB040DAO;

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

public class INSB040WRK {

    /**
     * EXCEL 파일 업로드
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSB040_ULD( CBox p_box, TrBox p_tr ) throws CException {
    	
        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";


        //엑셀파일 정보를 담기 위한 데이터셋
        GauceDataSet ds = new GauceDataSet();
        
        GauceDataRow dr = null;
        
        ds.addDataColumn(new GauceDataColumn("ENO_NM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ENO_NO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("HINU_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("OLD_AMT", GauceDataColumn.TB_STRING ));
        
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

                if(row.getPhysicalNumberOfCells() != 4)
                	
                    throw new BizException("엑셀파일의 셀의 갯수는 4개이어야 합니다!");

                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    
                    dr.setString( 1, POIUtil.getString(row, 1));
                    
                    dr.setString( 2, POIUtil.getString(row, 2));

                    dr.setString( 3, POIUtil.getString(row, 3));                    
                    
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
	 * 식당이용기록 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void INSB040_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_PERSON");
        GauceValueObject vo = null;

		INSB040DAO dao = new INSB040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			
			vo = voList.get(i);

            try {
            	
                this.INSB040_UPT(vo, p_box, p_tr);
                
            } catch(CException e) {
            	
                err_cnt++;
                
            }
            
		}

        resultMsg = "전체 "+voList.size()+"건 중 "+err_cnt+"건의 등록이 실패하였습니다.";

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        
	}
	
	
	public void INSB040_UPT(GauceValueObject vo, CBox p_box,  TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		INSB040DAO dao = new INSB040DAO("default", p_tr);

		dao.INSB040_UPT(vo, p_box);

	}	
	
	
	
}

