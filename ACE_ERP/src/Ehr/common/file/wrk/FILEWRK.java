package Ehr.common.file.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.FileUtils;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.common.file.dao.FILEDAO;

public class FILEWRK {
    private FILEDAO dao;

    /**
     * 파일 내역을 조회
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void FILE_SHR(CBox p_box, TrBox p_tr) throws CException {
		
		dao = new FILEDAO("default", p_tr);
		
		dao.FILE_SHR(p_box);
		
	}
    
    /**
     * 파일 내역을 저장
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void FILE_INS(CBox p_box, TrBox p_tr) throws CException {
    	
    	//System.out.println("p_box============"+p_box);
    	
        /** 첨부 파일 처리 **/
        GauceValueObject voList = p_tr.getGauceFileMultiUpload("FILE", "FILE_NAME", "UPLOAD_URL");
        
        GauceValueObject vo = null;
        
        dao = new FILEDAO("default", p_tr);
        
        for(int i=0; i<voList.size(); i++) {
            vo = voList.get(i);
            
            //insert일 경우와 file upload가 성공적으로 이루어진 경우에만
            if(vo.getInt("TX_MODE") == 2 && vo.getBoolean("FILE_ATTACHED_YN"))
                this.FILE_INS(p_box, vo, p_tr);
        }
    }
    
    
	public void FILE_INS(CBox p_box, GauceValueObject vo,  TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		FILEDAO dao = new FILEDAO("default", p_tr);
		FILEDAO dao2 = new FILEDAO("default", p_tr);
		
		String seq;
		
		seq = dao.getSeq_no();
		
		//System.out.println("seq============"+seq); 
		
		dao2.FILE_INS(p_box, vo, seq);

	}		    
    
    /**
     * 파일 내역을 삭제
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void FILE_DEL(CBox p_box, TrBox p_tr) throws CException {
        /** 첨부 파일 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("FILE");
        
        GauceValueObject vo = null;
        
        dao = new FILEDAO("default", p_tr);
        
        for(int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);
            
            //delete일 경우에만
            if(vo.getInt("TX_MODE") == 4) {
            	
                dao.FILE_DEL(p_box, vo);
                
                FileUtils.deleteFile(vo.get("FILE_URL"));
                
            }
        }       
    }
}
