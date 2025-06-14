import React, { useState, useEffect } from 'react'

import { DisplayCampaigns } from '../components';

const Home = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [campaigns, setCampaigns] = useState([]);


  // const fetchCampaigns = async () => {
  //   setIsLoading(true);
  //   const data = await getCampaigns();
  //   setCampaigns(data);
  //   setIsLoading(false);
  // }

  // useEffect(() => {
  //   if(contract) fetchCampaigns();
  // }, [address, contract]);

  return (
    <DisplayCampaigns 
      title="All Campaigns"
      isLoading={isLoading}
      campaigns={campaigns}
    />
  )
}

export default Home