/**
 *用户注册
 */
 
import { mPost } from "../utils/request/xhr";
 
const getRegister = (params) => mPost("/user/register", params);
 
export { getRegister };