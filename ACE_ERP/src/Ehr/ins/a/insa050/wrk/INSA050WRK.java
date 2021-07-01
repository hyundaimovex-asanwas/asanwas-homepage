package Ehr.ins.a.insa050.wrk;

import Ehr.ins.a.insa050.dao.INSA050DAO;
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
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class INSA050WRK {

    /**
     * EXCEL ���� ���ε�
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSA050_ULD( CBox p_box, TrBox p_tr ) throws CException {
    	
        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";


        //�������� ������ ��� ���� �����ͼ�
        GauceDataSet ds = new GauceDataSet();
        
        GauceDataRow dr = null;
        
        ds.addDataColumn(new GauceDataColumn("ENO_NM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ENO_NO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("NPEN_AMT", GauceDataColumn.TB_STRING ));

        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;

        try{
            //��ũ���� ����!
            workbook = new HSSFWorkbook(new POIFSFileSystem(is));

            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            sheet = workbook.getSheetAt(0);//ù��° ��Ʈ
            
            row     = null;
            
        }catch(Exception e) {
        	
            Log.err.println(e.getMessage());
            
        }

        if(sheet != null) {
        	
            //HEADER �κ� �ǳʶ� INDEX 1���� ����
        	
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	
                // ��Ʈ�� ���� ���� �ϳ��� ����
            	
                row = sheet.getRow(i);

                if(row.getPhysicalNumberOfCells() != 3)
                	
                    throw new BizException("���������� ���� ������ 3���̾�� �մϴ�!");

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
	 * �Ĵ��̿��� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void INSA050_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_PERSON");
        GauceValueObject vo = null;

		INSA050DAO dao = new INSA050DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			
			vo = voList.get(i);

            try {
            	
                this.INSA050_UPT(vo, p_box, p_tr);
                
            } catch(CException e) {
            	
                err_cnt++;
                
            }
            
		}

        resultMsg = "��ü "+voList.size()+"�� �� "+err_cnt+"���� ����� �����Ͽ����ϴ�.";

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        
	}
	
	
	public void INSA050_UPT(GauceValueObject vo, CBox p_box,  TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		INSA050DAO dao = new INSA050DAO("default", p_tr);

		dao.INSA050_UPT(vo, p_box);

	}	
	
	
	
}
