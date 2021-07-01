package kr.co.imjk.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class FileUtil{

	/**
	 * 파일의 내용을 읽는다<p>
	 *
	 * @param filename(String) 파일의 풀주소
	 * @return sb(String)
	 */
	public static String readFile(String filename) throws FileNotFoundException, IOException
	{
		StringBuffer sb = new StringBuffer();

	    try{

			FileReader fr = new FileReader(filename); // 파일을 읽는다.
			BufferedReader br = new BufferedReader(fr); // 파일을 버퍼에 담는다.
			String line;
			try{

				while((line=br.readLine())!=null){
					sb.append(line);
				}

			}catch(FileNotFoundException ex){
				//System.out.println("File not fount :" + filename);
			}catch(IOException ex){
				//System.out.println("IOException :" + ex.getMessage());
			}finally{
				if(fr!=null){
					try{
						fr.close();
					}catch(Exception e){}
				}
				if(br!=null){
					try{
						br.close();
					}catch(Exception e){}
				}
			}
		}catch(FileNotFoundException ex){
			//System.out.println("File not fount :" + filename);
		}

		return sb.toString();
	}
    
    /**
     * 디렉토리가 없을경우 생성<p>
     * 
     * @param abs_dir 절대경로
     */
    public static void mkdirs(String abs_dir){
        File f = new File(abs_dir);
        if(!f.exists()){
            f.mkdirs();
        }
    }
}
