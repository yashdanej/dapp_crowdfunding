// SPDX-Licence-Identifier: UNLICENCED
pragma solidity ^0.8.9;

contract CrowdFunding{
    struct Campaign{
        string name;
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint amountCollected;
        address[] donators;
        uint[] donations;
    }

    mapping(uint => Campaign) public campaigns;
    uint public numberOfCampaigns = 0;

    function createCampaign(address _owner, string memory _name, string memory _title, string memory _description, uint _target, uint _deadline) public returns (uint){
        Campaign storage campaign = campaigns[numberOfCampaigns];
        
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future");

        campaign.owner = _owner;
        campaign.name = _name;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateCampaign(uint _id) public payable {
        uint amount = msg.value;
        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        if(sent){
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonators(uint _id) view public returns (address[] memory, uint[] memory){
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory){
        Campaign[] memory allCompaigns = new Campaign[](numberOfCampaigns);
        for (uint256 i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaigns[i];
            allCompaigns[i] = item;
        }
        return allCompaigns;
    }
}