/**
 *用户登录
 */
 
import { mPost } from "../utils/request/xhr";
 
const getLogin = (params) => mPost("/user/loginAdmin", params);
 
export { getLogin };