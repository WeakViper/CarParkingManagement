import HomeNavbar from "../Home/HomeNavBar";

const ManageStats = () => {
    return (
        <div>
            <HomeNavbar sticky = "top" exact/>
            <h2 className="m-5" style={{color: "black", fontWeight: "bold"}}> Management Stats </h2>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
        </div>
    );
}
 
export default ManageStats;