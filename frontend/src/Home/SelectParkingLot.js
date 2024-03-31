import HomeNavBar from "./HomeNavBar";
import ParkingLots from "./ParkingLots";
import ViewPurchasesButton from "./ViewPurchasesButton";

const SelectParkingLot = () => {
    return (
        <div className="SelectParkingLot">
            <HomeNavBar sticky="top" exact />
            <div className="d-flex justify-content-start">
                <h1 className="h2 m-5" style={{color: "black", fontWeight: "bold"}}>
                    Our Parking Lots
                </h1>
            </div>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            <ParkingLots />
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            <ViewPurchasesButton />
        </div>
    );
}
 
export default SelectParkingLot;
