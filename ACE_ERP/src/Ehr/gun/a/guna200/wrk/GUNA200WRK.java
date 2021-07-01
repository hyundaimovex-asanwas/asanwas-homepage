package Ehr.gun.a.guna200.wrk;

import Ehr.gun.a.guna200.dao.GUNA200DAO;
import Ehr.gun.d.gund050.dao.GUND050DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA200WRK {

    /**
     * 근태휴일날짜를 조회해오는 WORK메소드.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA200_SHR(CBox p_box, TrBox p_tr) throws CException {

            GUNA200DAO dao = new GUNA200DAO("default", p_tr);
            GUNA200DAO dao2 = new GUNA200DAO("default", p_tr);
            GUNA200DAO dao3 = new GUNA200DAO("default", p_tr);     
            
            GauceDataSet dsT_DI_HOLIDAY = dao.GUNA200_SHR(p_box) ;
            
            GauceDataSet dsT_DI_DILIGENCE = dao2.GUNA200_SHR_02(p_box) ;
            
            GauceDataSet dsRESULT = new GauceDataSet() ;

            dsRESULT.addDataColumn(new GauceDataColumn("DAY_VAL",GauceDataColumn.TB_STRING ));//평가그룹
            dsRESULT.addDataColumn(new GauceDataColumn("HOL_GUB", GauceDataColumn.TB_STRING ));//본부
            dsRESULT.addDataColumn(new GauceDataColumn("REMARK_VAL",  GauceDataColumn.TB_STRING ));//소속
            dsRESULT.addDataColumn(new GauceDataColumn("REG_YMD",  GauceDataColumn.TB_STRING ));//직위
            dsRESULT.addDataColumn(new GauceDataColumn("WK",  GauceDataColumn.TB_STRING ));//사번
            dsRESULT.addDataColumn(new GauceDataColumn("CNT",  GauceDataColumn.TB_INT ));//성명
            dsRESULT.addDataColumn(new GauceDataColumn("COLOR_VAL", GauceDataColumn.TB_STRING ));//1차평가

            GauceDataRow dsRow = null;

    		for(int i=1;i<=dsT_DI_HOLIDAY.getDataRowCnt();i++){
    			
    			dsRow = new GauceDataRow(7);
    			
    			String DAY_VAL = GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "DAY_VAL");
    			
    			String REMARK_VAL = "";
    			
    			for(int j=1;j<=dsT_DI_DILIGENCE.getDataRowCnt();j++){
    				
    				String TEMP = GauceUtils.nameValue(dsT_DI_DILIGENCE, j, "ENO_NM") + GauceUtils.nameValue(dsT_DI_DILIGENCE, j, "COL_NEW") + " ";
    				
    				String LV   = GauceUtils.nameValue(dsT_DI_DILIGENCE, j, "LV");
    				
    				int k = 0;
    				
    				if(DAY_VAL.equals(LV)){
    					
    					k++;
    					
    					if(k%3 == 0){
    						
    						REMARK_VAL += (TEMP+"\n");
    						
    					}else{
    						
    						REMARK_VAL += (TEMP);
    						
    					}
    					
    				}
    			}

    			String HOL_GUB = GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "HOL_GUB");
    			String REG_YMD = GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "REG_YMD");
    			String WK = GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "WK");
    			String COLOR_VAL = GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "COLOR_VAL");

    			dsRow.setString(0, DAY_VAL);
    			dsRow.setString(1, HOL_GUB);
    			dsRow.setString(2, REMARK_VAL);
    			dsRow.setString(3, REG_YMD);
    			dsRow.setString(4, WK);
    			dsRow.setInt(5, Integer.parseInt(GauceUtils.nameValue(dsT_DI_HOLIDAY, i, "CNT")));
    			dsRow.setString(6, COLOR_VAL);

    			dsRESULT.addDataRow(dsRow);

    		}

    		p_tr.setOutDataSet( "DS_ONE", dsRESULT );
    		
            p_tr.setOutDataSet( "DS_TWO", dao3.GUNA200_SHR_01(p_box) );
            
    }
    
    
    public void GUNA200_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {

        GUNA200DAO dao = new GUNA200DAO("default", p_tr);
        
        //dao.GUNA200_SHR_DPT(p_box) ;
        
		/** GUND040DAO 객체 생성 후 관련 메소드 호출 */
		//GUND050DAO dao = new GUND050DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		dao.GUNA200_SHR_DPT(p_box);
		//p_tr.setOutDataSet( "dsT_DI_DPT",       dao.GUNA200_SHR_DPT(p_box) );        
        
        
    }
    
    
    
}

