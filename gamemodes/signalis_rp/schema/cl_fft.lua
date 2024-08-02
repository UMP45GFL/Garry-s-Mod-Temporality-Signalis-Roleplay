
-- FFT Size
local fftSize = 1024
local sampleRate = 44100  -- This should match the sample rate of your audio file

local frequencyTable = {
    20,
    40,
    60,
    100,
    150,
    200,
    300,
    400,
    500,
    700,
    800,
    900,
    1000,
    2000,
    3000,
    4000,
    5000,
    6000,
    7000,
    8000,
    9000,
    10000,
}

function AnalyzeFFT(channel)
    -- Table to store FFT data
    local fftData = {}
    if channel:FFT(fftData, fftSize) == 0 then
        return
    end

    -- Function to get the magnitude at a specific frequency
    local function getVolumeAtFrequency(frequency)
        local bin = math.floor((frequency / sampleRate) * fftSize) + 1
        return fftData[bin] or 0
    end

    /*
    -- Get volume levels at specific frequencies
    local volume500Hz = getVolumeAtFrequency(500)
    local volume2000Hz = getVolumeAtFrequency(2000)
    local volume10000Hz = getVolumeAtFrequency(10000)

    -- Print the results
    print("Volume at 500Hz:", volume500Hz)
    print("Volume at 2000Hz:", volume2000Hz)
    print("Volume at 10000Hz:", volume10000Hz)
    */

    local retData = {}
    for i=1, 22 do
        retData[i] = getVolumeAtFrequency(frequencyTable[i])
    end

    return retData
end
