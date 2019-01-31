package file;

public class FileDTO {
	
	String fileName;
	String fileRealName;
	String text;
	String sort;
	
	
	public FileDTO(String fileName, String fileRealName, String sort,String text) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.text = text;
		this.sort=sort;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileRealName() {
		return fileRealName;
	}
	
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}


}
