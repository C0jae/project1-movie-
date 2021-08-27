package vo;

public class SignupVo {
  private String id;
  private String password;
  private String name;
  private String email;
  private String tel;
  private String mem_code;
  
  public SignupVo() {
	  
  }

public SignupVo(String id, String  password, String name, String email, String tel ,String mem_code) {
	super();
	this.id = id;
	this.password = password;
	this.name = name;
	this.email = email;
	this.tel = tel;
	this.mem_code = mem_code;
}



@Override
public String toString() {
	return "SignupVo [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", tel=" + tel
			+ "]";
}

//getter , setter
public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getTel() {
	return tel;
}

public void setTel(String tel) {
	this.tel = tel;
}
public void seMem_code(String mem_code) {
	this.mem_code = mem_code;
}
public String getMem_code() {
	return null;
}
}





  
  

