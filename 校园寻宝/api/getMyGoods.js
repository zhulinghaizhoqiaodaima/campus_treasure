import { mGet, mPost } from "../utils/request/xhr";
 
const getMyGoods = (params) => mGet("/goods", params);
 
export { getMyGoods };