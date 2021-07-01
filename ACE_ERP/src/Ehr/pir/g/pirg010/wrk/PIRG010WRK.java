package Ehr.pir.g.pirg010.wrk;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.imageio.ImageIO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.FileUtil;

public class PIRG010WRK {
	
    private String DIR_PATH;
    
    private String REAL_PATH;
    
    private String TEMP_PATH;
    
    public PIRG010WRK() throws BizException {
    	
        //정의된 path 조회해 오기
        Configuration conf;
        
        try {
        	
            conf = Configuration.getInstance();
            
            DIR_PATH = conf.get("framework.file.upload.pds");
             
            //정의된 path의 실재 경로를 가져옴
            URL filePath = new FileUtil().getClass().getResource(DIR_PATH);
            
            //실재 경로가 없으면 정의된 경로로 파일을 읽어옴
            REAL_PATH = filePath != null ? filePath.getPath() : DIR_PATH;
            
            TEMP_PATH = REAL_PATH+File.separator+"temp";
            
        } catch (CException e) {
        	
            throw new BizException("업로드 환경 변수가 없습니다. 파일을 조회해 올 수 없습니다.");
            
        }
        
    }



    /**
     * temp 폴더에 있는 사진 모두를 upload 폴더에 올린다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void PIRG010_SAV(CBox p_box, TrBox p_tr) throws CException {
        File dir = null;
        File file = null;

        String[] child = null;
        String fileName = null;
        String ext = null;

        InputStream is = null;

        //System.out.println("p_box==============="+p_box);        
        
        //임시 파일들의 리스트를 조회해 온다.
        //dir = new File(TEMP_PATH);
        dir = new File(TEMP_PATH);
        
        //System.out.println("dir==============="+dir);
        
     
        
        if(dir.isDirectory()) {
        	
            child = dir.list();

            for(int i=0; i<child.length; i++) {
            	
                fileName = child[i];
                
                file = new File(dir, fileName);

                //System.out.println("file==============="+file);          
                
                //System.out.println("REAL_PATH==============="+REAL_PATH);                   
                REAL_PATH = "/asanwas/Ehr/file";
                //System.out.println("REAL_PATH==============="+REAL_PATH);                
                //파일일 경우 파일을 upload 폴더에 옮김
                if(file.isFile()){
                	
                    ext = fileName.substring(fileName.lastIndexOf(".") + 1);

                    //System.out.println("ext==============="+ext);   
                    
                    //확장자가 jpg 인 녀석만 가져오기
                    if(ext != null && ext.equals("jpg")) {
                    	
                        try {

                            //System.out.println("REAL_PATH333333333333==============="+REAL_PATH);                         	
                            //System.out.println("fileName44444444444==============="+fileName);                         	
                            //원본파일을 읽어 stream으로 변환시킨다.
                            is = new FileInputStream(file);

                            //upload 폴더에 새로 파일을 생성한다.
                            FileUtil.createFile(REAL_PATH, fileName, is);

                            //기존 파일은 삭제 한다.
                            file.delete();

                        } catch (FileNotFoundException e) {
                        	
                            e.printStackTrace();
                            
                        } catch (IOException e) {
                        	
                            e.printStackTrace();
                            
                        } finally {
                        	
                            try {
                                is.close();
                                
                            } catch (IOException e) {
                            	
                            }
                        }
                    }
                }
            }
        }
    }

	/**
	 * 사진파일을 업로드 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PIRG010_ULD(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("dsFILE_UPLOAD");
        GauceValueObject vo = null;

        InputStream[] isList = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL");
        InputStream is = null;

        //System.out.println("p_box==============="+p_box);
        
        ParameterBlock pb = null;

        BufferedImage bi = null;
        
        File writeFile = null;

        String fileName = null;
        String ext = null;

        for (int i = 0; i < voList.size(); i++) {
        	
            vo = voList.get(i);
            
            //System.out.println("vo==============="+vo);
            
            is = isList[i];

            fileName    = vo.get("FILE_NAME");
            
            //System.out.println("fileName==============="+fileName);            
            
            ext         = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            
            //System.out.println("ext==============="+ext);                
            
            fileName    = fileName.substring(0, fileName.lastIndexOf("."));

            //System.out.println("fileName==============="+fileName);
            
            //System.out.println("TEMP_PATH1111111111111111111111111111==============="+TEMP_PATH);            
            
            try{

                    bi  = ImageIO.read(is);

                //임시 경로에 이미지를 저장해 놓는다.
                writeFile = new File(TEMP_PATH+File.separator+fileName+".jpg");
                
                ImageIO.write(bi, "jpg", writeFile);
                
                this.PIRG010_SAV(p_box, p_tr);
                
            }catch(IOException e){
            	
                throw new BizException("이미지 업로드가 실패하였습니다.");
            }
        }
	}


}
