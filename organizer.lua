-- ==========================================
-- LUA FILE ORGANIZER
-- ==========================================


-- ==========================================
-- CHOOSE FOLDER
-- ==========================================

print("Enter the folder you want to organize:")
local folder = io.read()


-- ==========================================
-- CHECK IF FOLDER EXISTS
-- ==========================================

-- Windows command that checks whether
-- the folder exists.
local checkCommand =
    'if exist "' .. folder .. '\\" (echo yes) else (echo no)'

local check = io.popen(checkCommand)

local folderExists = check:read("*l")

check:close()


-- If the folder doesn't exist, stop.
if folderExists ~= "yes" then
    print("ERROR: Folder does not exist!")
    return
end


-- ==========================================
-- FILE CATEGORIES
-- ==========================================

local categories = {

    -- Images
    png = "Images",
    jpg = "Images",
    jpeg = "Images",
    gif = "Images",
    webp = "Images",

    -- Videos
    mp4 = "Videos",
    mkv = "Videos",
    avi = "Videos",
    mov = "Videos",

    -- Archives
    zip = "Archives",
    rar = "Archives",
    ["7z"] = "Archives",

    -- Documents
    txt = "Documents",
    pdf = "Documents",
    doc = "Documents",
    docx = "Documents"
}


-- ==========================================
-- GET FILE CATEGORY
-- ==========================================

local function getCategory(fileName)

    -- Get extension:
    --
    -- photo.png -> png
    -- video.mp4 -> mp4
    local extension =
        fileName:match("%.([^%.]+)$")


    -- Convert extension to lowercase.
    --
    -- PNG -> png
    -- MP4 -> mp4
    if extension ~= nil then
        extension = extension:lower()
    end


    -- Search our categories table.
    local category = categories[extension]


    -- Unknown extension goes into Other.
    if category == nil then
        category = "Other"
    end


    return category
end


-- ==========================================
-- CONFIRM
-- ==========================================

print("")
print("Folder to organize: " .. folder)

while true do

    print("Are you sure you want to organize this folder? (yes/no)")

    local answer = io.read():lower()


    -- YES
    if answer == "yes" or answer == "y" then

        print("")
        print("Starting organizer...")
        print("")

        break


    -- NO
    elseif answer == "no" or answer == "n" then

        print("Cancelled.")
        return


    -- INVALID ANSWER
    else

        print("Invalid choice. Please type yes or no.")
        print("")

    end
end


-- ==========================================
-- READ FILES
-- ==========================================

-- /b   = only show names
-- /a-d = show files only, not folders
local command =
    'dir "' .. folder .. '" /b /a-d 2>nul'

local result = io.popen(command)


-- Make sure the command opened correctly.
if result == nil then
    print("ERROR: Could not read the folder!")
    return
end


-- ==========================================
-- ORGANIZE FILES
-- ==========================================

local movedFiles = 0


for fileName in result:lines() do

    -- Find which category the file belongs to.
    local category =
        getCategory(fileName)


    -- Example:
    --
    -- folder\Images
    local categoryFolder =
        folder .. "\\" .. category


    -- Create the category folder if
    -- it doesn't already exist.
    os.execute(
        'if not exist "' ..
        categoryFolder ..
        '" mkdir "' ..
        categoryFolder ..
        '"'
    )


    -- Original file location.
    --
    -- folder\photo.png
    local oldPath =
        folder .. "\\" .. fileName


    -- New file location.
    --
    -- folder\Images\photo.png
    local newPath =
        categoryFolder ..
        "\\" ..
        fileName


    -- Move the file.
    local success, errorMessage =
        os.rename(oldPath, newPath)


    -- Check whether it worked.
    if success then

        print(fileName, "->", category)

        -- Add 1 to our moved-file counter.
        movedFiles = movedFiles + 1

    else

        print("ERROR moving: " .. fileName)

        if errorMessage ~= nil then
            print(errorMessage)
        end

    end
end


-- Close the folder reader.
result:close()


-- ==========================================
-- FINISHED
-- ==========================================

print("")

if movedFiles == 0 then

    print("No files to organize.")

else

    print("Finished organizing files!")
    print("Files moved: " .. movedFiles)

end